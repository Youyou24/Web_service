import { DataTypes } from "sequelize";
import sequelize from "../db";

const Anomalies = sequelize.define('anomalies', {
    id_anomalie: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    designation: {
      type: DataTypes.STRING(100)
    }
  }, {
    tableName: 'anomalies', // Assurez-vous que le nom de la table correspond à celui de votre base de données
    timestamps:false
  });

export default Anomalies;