# CI/CD pour Air-FLE Backend

Ce répertoire contient les configurations pour l'intégration continue (CI) et le déploiement continu (CD) pour le projet Air-FLE Backend.

## Workflows GitHub Actions

### CI (Intégration continue)

Le workflow CI est déclenché à chaque push sur les branches `develop` et `main`, ainsi que sur les pull requests vers ces branches.

Ce workflow effectue les opérations suivantes :
- Vérifie le code avec ESLint (linting)
- Compile l'application (build)
- Exécute les tests unitaires
- Construit l'image Docker pour vérifier que celle-ci est fonctionnelle

### CD (Déploiement continu)

Le workflow CD est déclenché uniquement lors d'un push sur la branche `main`.

Ce workflow effectue les opérations suivantes :
- Construit l'image Docker pour la production
- Publie l'image sur Docker Hub
- Étiquette l'image avec le tag `latest`

## Secrets nécessaires

Pour que le workflow CD fonctionne correctement, vous devez configurer les secrets suivants dans les paramètres du dépôt GitHub :

- `DOCKERHUB_USERNAME` : Votre nom d'utilisateur Docker Hub
- `DOCKERHUB_TOKEN` : Un token d'accès Docker Hub (pas votre mot de passe)

## Comment utiliser ces workflows

### Pour le développement

1. Créez une branche à partir de `develop`
2. Poussez vos commits vers cette branche
3. Créez une Pull Request vers `develop`
4. Le workflow CI sera automatiquement déclenché pour valider votre code

### Pour la production

1. Créez une Pull Request de `develop` vers `main`
2. Une fois fusionnée, le workflow CD sera automatiquement déclenché
3. L'image Docker sera construite et publiée sur Docker Hub

## Intégration avec les environnements

Les images Docker construites par le CD sont disponibles à l'adresse `docker.io/DOCKERHUB_USERNAME/air-fle-back:latest`, où :
- `DOCKERHUB_USERNAME` est votre nom d'utilisateur Docker Hub défini dans les secrets 