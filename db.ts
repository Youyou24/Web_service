import { Sequelize } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

const sequelize = new Sequelize(
  process.env.DB_NAME || 'WMS_TEST',
  process.env.DB_USER || '',
  process.env.DB_PASSWORD || '',
  {
    dialect: 'mssql',
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '1433'),
    dialectOptions: {
      authentication: {
        type: 'ntlm',
        options: {
          domain: process.env.DB_DOMAIN || 'NPGANDOUR',
          userName: process.env.DB_USERNAME || 'yannick.atse',
          password: process.env.DB_PASSWORD || 'Youyou@24',
        },
      },
      options: {
        encrypt: false,
        trustServerCertificate: true,
      },
    },
    logging: false,
  }
);

export default sequelize;
