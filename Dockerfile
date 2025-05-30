FROM node:20-alpine AS base

# Install system dependencies and diagnostic tools
RUN apk add --no-cache curl netcat-openbsd

# Set the working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# -------------------
# DEVELOPMENT IMAGE
# -------------------
FROM base AS dev

# Install all dependencies (including devDependencies)
RUN npm install --legacy-peer-deps

# Install Nest CLI globally for development
RUN npm install -g @nestjs/cli

# Expose the development port
EXPOSE 3001

# Command to start the application in development mode with hot reload
CMD ["npm", "run", "start:dev"]

# -------------------
# BUILDER IMAGE
# -------------------
FROM base AS builder

# Install all dependencies
RUN npm ci

# Copy the source code
COPY . .

# Build the application
RUN npm run build

# -------------------
# PRODUCTION IMAGE
# -------------------
FROM base AS production

# Set NODE_ENV to production
ENV NODE_ENV=production

# Install only production dependencies
RUN npm ci --only=production

# Copy the built application from the builder stage
COPY --from=builder /app/dist ./dist

# Expose the production port
EXPOSE 3001

# Command to start the application in production mode
CMD ["node", "dist/main"]