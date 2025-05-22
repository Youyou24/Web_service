import { DataTypes } from "sequelize";
import sequelize from "../db";
import EnteteFicheAnomalie from "./EnteteFicheAnomalie";
import Photo from "./Photo";

const PhotoHasFicheAnomalie = sequelize.define('photo_has_ficheAnomalie', {
  id_photo_has_ficheAnomalie: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  id_fiche_anomalie_FK: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  id_photo_FK: {
    type: DataTypes.INTEGER,
    allowNull: false
  }
}, {
  tableName: 'photo_has_ficheAnomalie',
  timestamps: false
});

// Relations
EnteteFicheAnomalie.hasMany(PhotoHasFicheAnomalie, {
  foreignKey: 'id_fiche_anomalie_FK',
  as: 'photos'
});

PhotoHasFicheAnomalie.belongsTo(EnteteFicheAnomalie, {
  foreignKey: 'id_fiche_anomalie_FK',
  as: 'fiche'
});

Photo.hasMany(PhotoHasFicheAnomalie, {
  foreignKey: 'id_photo_FK',
  as: 'ficheAnomalies'
});

PhotoHasFicheAnomalie.belongsTo(Photo, {
  foreignKey: 'id_photo_FK',
  as: 'photo'
});

export default PhotoHasFicheAnomalie; 