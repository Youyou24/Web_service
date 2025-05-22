// index.ts

import express, { Request, Response } from 'express';
import dotenv from 'dotenv';
import axios from 'axios';
import sequelize from './db';
import cron from 'node-cron';
import { Model } from 'sequelize';
import qs from 'querystring';
import fs from 'fs';

import EnteteFicheAnomalie from './models/EnteteFicheAnomalie';
import DetailsFicheAnomalie from './models/DetailsFicheAnomalie';
import TypeAnomalies from './models/TypeAnomalies';
import Anomalies from './models/Anomalies';

interface IEnteteFicheAnomalie extends Model {
  of: string;
  designation_article: string;
  numero_lot: string;
  created_by: string;
  createdAt: Date;
  details?: IDetailsFicheAnomalie[];
}

interface IDetailsFicheAnomalie extends Model {
  typeAnomalie?: ITypeAnomalies;
}

interface ITypeAnomalies extends Model {
  designation: string;
  anomalie?: IAnomalies;
}

interface IAnomalies extends Model {
  designation: string;
}

interface IUser {
  id_user: number;
  name_user: string;
  whatsapp: string;
}

dotenv.config();
const app = express();
app.use(express.json());

const WHATSAPP_TOKEN = 'mobwo0x2qo6c3dxy';
const WHATSAPP_INSTANCE = 'instance87405';
const WHATSAPP_URL = `https://api.ultramsg.com/${WHATSAPP_INSTANCE}/messages/chat`;
const WHATSAPP_IMAGE_URL = `https://api.ultramsg.com/${WHATSAPP_INSTANCE}/messages/image`;
const WHATSAPP_STATUS_URL = `https://api.ultramsg.com/${WHATSAPP_INSTANCE}/instance/status`;
const USERS_API_URL = 'http://10.10.2.17:8000/users';

const API_TIMEOUT = 60000;
const API_RETRY_ATTEMPTS = 3;
const MAX_MESSAGE_LENGTH = 1000;

function splitMessage(message: string): string[] {
  const messages: string[] = [];
  const lines = message.split('\n');
  let currentMessage = '';

  for (const line of lines) {
    if ((currentMessage + '\n' + line).length > MAX_MESSAGE_LENGTH) {
      messages.push(currentMessage);
      currentMessage = line;
    } else {
      currentMessage += (currentMessage ? '\n' : '') + line;
    }
  }

  if (currentMessage) messages.push(currentMessage);
  return messages;
}

async function fetchUsers(): Promise<IUser[]> {
  let lastError: any;

  for (let attempt = 1; attempt <= API_RETRY_ATTEMPTS; attempt++) {
    try {
      console.log(`[${new Date().toISOString()}] Tentative ${attempt}/${API_RETRY_ATTEMPTS} de récupération des utilisateurs...`);

      const response = await axios.get(USERS_API_URL, {
        timeout: API_TIMEOUT,
        headers: { 'Accept': 'application/json' }
      });

      const users = response.data.filter((user: IUser) =>
        user.whatsapp && (
          user.name_user.toLowerCase().includes('yannick atse') ||
          user.name_user.toLowerCase().includes('junior tchimou') ||
          user.name_user.toLowerCase().includes('imad ghamloush')
        )
      );

      if (users.length === 0) {
        console.log(`[${new Date().toISOString()}] Aucun utilisateur trouvé`);
        return [];
      }

      console.log(`[${new Date().toISOString()}] Utilisateurs trouvés:`, users.map((u: IUser) => ({
        name: u.name_user,
        whatsapp: u.whatsapp
      })));

      return users;
    } catch (error: any) {
      lastError = error;
      console.error(`[${new Date().toISOString()}] Erreur lors de la tentative ${attempt}: ${error.message}`);
      await new Promise(resolve => setTimeout(resolve, attempt * 2000));
    }
  }

  throw new Error(`Échec de la récupération des utilisateurs: ${lastError.message}`);
}

async function sendWhatsAppMessage(to: string, message: string): Promise<boolean> {
  try {
    const payload = { token: WHATSAPP_TOKEN, to, body: message };
    const config = { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } };

    const response = await axios.post(WHATSAPP_URL, qs.stringify(payload), config);
    console.log(`[${new Date().toISOString()}] Message envoyé:`, response.data);
    return true;
  } catch (error: any) {
    console.error(`[${new Date().toISOString()}] Erreur WhatsApp:`, error.message);
    return false;
  }
}

async function sendWhatsAppImage(to: string, imagePath: string): Promise<boolean> {
  try {
    if (!fs.existsSync(imagePath)) {
      console.error(`[${new Date().toISOString()}] Le fichier image n'existe pas: ${imagePath}`);
      return false;
    }

    console.log(`[${new Date().toISOString()}] Tentative d'envoi de l'image à ${to}`);
    const imageBuffer = fs.readFileSync(imagePath);
    const base64Image = imageBuffer.toString('base64');

    const payload = {
      token: WHATSAPP_TOKEN,
      to: to,
      image: base64Image
    };

    console.log(`[${new Date().toISOString()}] Envoi de la requête à l'API WhatsApp...`);
    const response = await axios.post(WHATSAPP_IMAGE_URL, qs.stringify(payload), {
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
    });
    
    console.log(`[${new Date().toISOString()}] Réponse de l'API WhatsApp:`, response.data);
    return true;
  } catch (error: any) {
    console.error(`[${new Date().toISOString()}] Erreur détaillée WhatsApp (image):`, {
      message: error.message,
      response: error.response?.data,
      status: error.response?.status
    });
    return false;
  }
}

async function sendFicheAnomalieNotifications() {
  try {
    console.log(`[${new Date().toISOString()}] Recherche des fiches d'anomalies...`);

    const fiches = await EnteteFicheAnomalie.findAll({
      include: [{
        model: DetailsFicheAnomalie,
        as: 'details',
        include: [{
          model: TypeAnomalies,
          as: 'typeAnomalie',
          include: [{ model: Anomalies, as: 'anomalie' }]
        }]
      }]
    }) as IEnteteFicheAnomalie[];

    if (fiches.length === 0) {
      console.log(`[${new Date().toISOString()}] Aucune fiche anomalie trouvée.`);
      return;
    }

    // Regrouper les fiches par date de création
    const fichesParDate = fiches.reduce((acc, fiche) => {
      const date = fiche.createdAt.toISOString().split('T')[0]; // Format YYYY-MM-DD
      if (!acc[date]) {
        acc[date] = [];
      }
      acc[date].push(fiche);
      return acc;
    }, {} as Record<string, IEnteteFicheAnomalie[]>);

    const users = await fetchUsers();
    if (users.length === 0) throw new Error('Aucun utilisateur trouvé.');

    // Envoyer un message pour chaque date
    for (const [date, fichesDuJour] of Object.entries(fichesParDate)) {
      const messageLines = fichesDuJour.map(fiche => {
        const details = fiche.details?.map(d => {
          const type = d.typeAnomalie?.designation || 'Type inconnu';
          const cause = d.typeAnomalie?.anomalie?.designation || 'Cause inconnue';
          return `- ${cause} ➤ ${type}`;
        }).join('\n') || 'Aucun détail';

        return `📋 OF: ${fiche.of}
📦 Article: ${fiche.designation_article}
🏷️ Lot: ${fiche.numero_lot}
👤 Créé par: ${fiche.created_by}
📝 Détails:
${details}
-------------------`;
      });

      const message = `📊 Fiches Anomalies du ${new Date(date).toLocaleString('fr-FR')}
Nombre de fiches : ${fichesDuJour.length}

${messageLines.join('\n\n')}`;

      // Envoyer le message à chaque utilisateur
      for (const user of users) {
        const success = await sendWhatsAppMessage(user.whatsapp, message);
        if (!success) {
          console.error(`[${new Date().toISOString()}] Échec d'envoi à ${user.name_user}`);
        } else {
          console.log(`[${new Date().toISOString()}] Message envoyé à ${user.name_user} pour la date ${date}`);
        }
      }
    }
  } catch (error: any) {
    console.error(`[${new Date().toISOString()}] Erreur détaillée:`, {
      message: error.message,
      response: error.response?.data,
      status: error.response?.status
    });
  }
}

// Serveur Express
sequelize.authenticate()
  .then(() => {
    console.log('✅ Connexion à SQL Server réussie.');
    app.listen(3030, () => {
      console.log('🚀 Serveur en écoute sur le port 3030');
    });
  })
  .catch((err: any) => {
    console.error('❌ Échec de la connexion à SQL Server :', err.message || err);
  });

// Route pour envoyer une image
app.get('/send-image', async (_req: Request, res: Response) => {
  try {
    await sendPhotoToUsers();
    res.status(200).json({ success: true, message: 'Image envoyée' });
  } catch (err: any) {
    res.status(500).json({ success: false, error: err.message });
  }
});

// Fonction pour envoyer la photo
async function sendPhotoToUsers() {
  try {
    console.log(`[${new Date().toISOString()}] Envoi de la photo...`);
    const users = await fetchUsers();
    const imagePath = 'C:/Users/yannick.atse/Desktop/logo_image.png';

    for (const user of users) {
      const success = await sendWhatsAppImage(user.whatsapp, imagePath);
      if (!success) {
        console.error(`[${new Date().toISOString()}] Échec d'envoi de l'image à ${user.name_user}`);
      } else {
        console.log(`[${new Date().toISOString()}] Image envoyée à ${user.name_user}`);
      }
    }
  } catch (error: any) {
    console.error(`[${new Date().toISOString()}] Erreur lors de l'envoi de la photo:`, error.message);
  }
}

// Cron : toutes les 30 secondes
cron.schedule('*/30 * * * * *', async () => {
  console.log(`[${new Date().toISOString()}] ⏱️ Tâche cron déclenchée`);
  await sendPhotoToUsers();
});
