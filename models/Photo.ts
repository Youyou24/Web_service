import { DataTypes } from "sequelize";
import sequelize from "../db";

const Photo = sequelize.define('photos', {
  id_photo: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  originalname: {
    type: DataTypes.STRING(191),
    allowNull: true
  },
  filename: {
    type: DataTypes.STRING(191),
    allowNull: true
  },
  size: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  mimetype: {
    type: DataTypes.STRING(191),
    allowNull: true
  }
}, {
  tableName: 'photos',
  timestamps: false
});

export default Photo; 