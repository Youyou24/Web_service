import sequelize from './db';

(async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Connexion Sequelize OK');
  } catch (err) {
    console.error('❌ Erreur Sequelize :', err);
  }
})();
