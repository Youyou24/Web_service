import { DataTypes } from "sequelize";
import sequelize from "../db";
import Of from "./Of";

const EnteteFicheAnomalie = sequelize.define('entete_fiche_anomalie', {
    id_entete_fiche_anomalie: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    of: {
        type: DataTypes.STRING(15),
    },
    code_article: {
        type: DataTypes.STRING(20)
    },
    designation_article: {
        type: DataTypes.STRING(100),
    },
    numero_lot: {
        type: DataTypes.STRING(10),
      },
      numero_lot_controle: {
        type: DataTypes.STRING(20),
      },
    remarque: {
        type: DataTypes.STRING,
        allowNull:true
    },
    commentaire_decision:{
        type: DataTypes.STRING,
    },
    accepte:{
      type: DataTypes.INTEGER,
    },
    accept_except:{
      type: DataTypes.INTEGER,
    },
    refuse:{
      type: DataTypes.INTEGER,
    },
    created_by: {
        type: DataTypes.STRING(50)
      },
  }, {
    tableName: 'entete_fiche_anomalie' // Assurez-vous que le nom de la table correspond à celui de votre base de données
  });

  Of.hasMany(EnteteFicheAnomalie,{foreignKey:'id_of_FK'})
  EnteteFicheAnomalie.belongsTo(Of,{foreignKey:'id_of_FK'})

export default EnteteFicheAnomalie;