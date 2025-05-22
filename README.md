# Web Service - Envoi de Photos WhatsApp

Ce service permet d'envoyer automatiquement des photos via WhatsApp à des utilisateurs spécifiques.

## Fonctionnalités

- Envoi automatique de photos toutes les 30 secondes
- Envoi manuel via une route API
- Support pour plusieurs destinataires
- Logs détaillés pour le débogage

## Installation

1. Cloner le repository :
```bash
git clone https://github.com/Youyou24/Web_service.git
cd Web_service
```

2. Installer les dépendances :
```bash
npm install
```

3. Configurer les variables d'environnement :
- Créer un fichier `.env` à la racine du projet
- Ajouter les variables nécessaires (voir `.env.example`)

## Utilisation

1. Démarrer le serveur :
```bash
npm start
```

2. Le serveur sera accessible sur `http://localhost:3030`

3. Pour envoyer une photo manuellement :
- Visiter `http://localhost:3030/send-image`

## Configuration

- Les utilisateurs sont configurés dans l'API `http://10.10.2.17:8000/users`
- Le chemin de l'image est configuré dans `index.ts`
- L'intervalle d'envoi automatique est configuré dans la tâche cron

## Dépendances

- express
- axios
- node-cron
- dotenv
- typescript
- ts-node

## Licence

MIT 
