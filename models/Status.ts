import { DataTypes } from "sequelize";
import sequelize from "../db";

const Status = sequelize.define('status', {
    id_status: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    designation: {
      type: DataTypes.STRING(100)
    },
    color: {
      type: DataTypes.STRING(20)
    },
    partiellement:{
      type: DataTypes.INTEGER
    },
    viewProcess:{
      type: DataTypes.INTEGER
    }
  }, {
    tableName: 'status' // Assurez-vous que le nom de la table correspond à celui de votre base de données
  });
  
export default Status;