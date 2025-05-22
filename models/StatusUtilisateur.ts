import { DataTypes } from "sequelize";
import sequelize from "../db";

const StatusUtilisateur = sequelize.define('statusUtilisateur', {
    id_statusUtilisateur: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    code: {
        type: DataTypes.STRING(20)
      },
    designation: {
      type: DataTypes.STRING(50)
    },
    color: {
      type: DataTypes.STRING(20)
    },
    activer: {
        type: DataTypes.INTEGER
      },
    vueWeb: {
      type: DataTypes.INTEGER
    },
    vueMobil: {
      type: DataTypes.INTEGER
    },
  }, {
    tableName: 'statusUtilisateur' // Assurez-vous que le nom de la table correspond à celui de votre base de données
  });
  
export default StatusUtilisateur;