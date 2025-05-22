import { DataTypes } from "sequelize";
import sequelize from "../db";
import Anomalies from "./Anomalies";

const TypeAnomalies = sequelize.define('type_anomalies', {
    id_typeAnomalie: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    designation: {
      type: DataTypes.STRING(100)
    }
  }, {
    tableName: 'type_anomalies', // Assurez-vous que le nom de la table correspond à celui de votre base de données
    timestamps:false
  });

  Anomalies.hasMany(TypeAnomalies, {
    foreignKey: 'id_anomalie_FK',
    as: 'types'
  });
  TypeAnomalies.belongsTo(Anomalies, {
    foreignKey: 'id_anomalie_FK',
    as: 'anomalie'
  });

  export default TypeAnomalies;