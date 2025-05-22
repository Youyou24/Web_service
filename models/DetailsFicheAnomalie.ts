import { DataTypes } from "sequelize";
import sequelize from "../db";
import EnteteFicheAnomalie from "./EnteteFicheAnomalie";
import TypeAnomalies from "./TypeAnomalies";

const DetailsFicheAnomalie = sequelize.define('detail_fiche_anomalie', {
    id_detail_fiche_anomalie: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement:true
    },
    created_by: {
        type: DataTypes.STRING(50)
      },
  }, {
    tableName: 'detail_fiche_anomalie' // Assurez-vous que le nom de la table correspond à celui de votre base de données
  });

  EnteteFicheAnomalie.hasMany(DetailsFicheAnomalie, {
    foreignKey: 'id_entete_fiche_anomalie_FK',
    as: 'details'
  });
  DetailsFicheAnomalie.belongsTo(EnteteFicheAnomalie, {
    foreignKey: 'id_entete_fiche_anomalie_FK',
    as: 'entete'
  });

  TypeAnomalies.hasMany(DetailsFicheAnomalie, {
    foreignKey: 'id_typeAnomalie_FK',
    as: 'details'
  });
  DetailsFicheAnomalie.belongsTo(TypeAnomalies, {
    foreignKey: 'id_typeAnomalie_FK',
    as: 'typeAnomalie'
  });

export default DetailsFicheAnomalie;