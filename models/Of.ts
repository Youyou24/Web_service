import { DataTypes } from "sequelize";
import sequelize from "../db";
import Status from "./Status";
import StatusUtilisateur from "./StatusUtilisateur";

const Of = sequelize.define('Of', {
    id_of: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    of: {
      type: DataTypes.STRING(15),
      allowNull:false
    },
    of_secondary: {
      type: DataTypes.STRING(15),
    },
    quantite: {
      type: DataTypes.FLOAT,
      allowNull:true
    },
    qte_remplir:{
      type: DataTypes.FLOAT
    },
    qte_polypacker:{
      type: DataTypes.FLOAT
    },
    qte_livrer:{
      type: DataTypes.FLOAT
    },
    qte_ctr_recept_logistique:{
      type: DataTypes.FLOAT
    },
    qte_pce_recept_logistique:{
      type: DataTypes.FLOAT
    },
    qte_livrer_semi:{
      type: DataTypes.FLOAT
    },
    date_recept_logistique:{
      type:DataTypes.DATE
    },
    unite: {
      type: DataTypes.STRING(15),
      allowNull:false
    },
    process: {
      type: DataTypes.STRING(15),
      allowNull:true
    },
    debut_ordonnancement:{
      type: DataTypes.DATEONLY,
      allowNull:true
    },
    date_creation_of: {
      type: DataTypes.DATEONLY,
      allowNull:true
    },
    heure_creation_of: {
      type: DataTypes.TIME,
      allowNull:true
    },
    section_code: {
      type: DataTypes.STRING(5),
      allowNull:true
    },
    section_nom: {
      type: DataTypes.STRING(50),
      allowNull:true
    },
    poste_travail: {
      type: DataTypes.STRING(12),
      allowNull:true
    },
    code_article: {
      type: DataTypes.STRING(20)
    },
    designation_article: {
      type: DataTypes.STRING(100),
      allowNull:true
    },
    zone_tampon: {
      type: DataTypes.STRING(6),
      allowNull:true
    },
    magasin: {
      type: DataTypes.STRING(10)
    },
    type_article: {
      type: DataTypes.STRING(6),
      allowNull:true
    },
    gestionnaire: {
      type: DataTypes.STRING(6),
      allowNull:true
    },
    colisage: {
      type: DataTypes.FLOAT,
      allowNull:true
    },
    gerbage: {
      type: DataTypes.INTEGER,
      allowNull:true
    },
    numero_lo: {
      type: DataTypes.STRING(10),
      allowNull:true
    },
    numero_lot_controle: {
      type: DataTypes.STRING(20),
      allowNull:true
    },
    division: {
      type: DataTypes.STRING(10),
      allowNull:true
    },
    fiche_anomalie: {
      type: DataTypes.INTEGER,
    },
    download_by: {
      type: DataTypes.STRING(100),
      allowNull:true
    },
    date_Livraison:{
      type:DataTypes.DATE
    },
    id_status_production:{
      type:DataTypes.INTEGER
    },
  }, {
    tableName: 'Of', 
  });

Status.hasMany(Of,{foreignKey:'id_status_FK'})
Of.belongsTo(Status,{foreignKey:'id_status_FK'})

StatusUtilisateur.hasMany(Of,{foreignKey:'id_statusUtilisateur_FK'})
Of.belongsTo(StatusUtilisateur,{foreignKey:'id_statusUtilisateur_FK'})

export default Of;