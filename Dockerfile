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