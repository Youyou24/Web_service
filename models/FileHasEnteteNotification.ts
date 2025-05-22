import { DataTypes } from "sequelize";
import sequelize from "../db";

const FileHasEnteteNotification = sequelize.define('filehasentetenotification', {
  notificationId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  enteteNotificationIdFK: {
    type: DataTypes.INTEGER,
    allowNull: false
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
  tableName: 'filehasentetenotification',
  timestamps: false
});

export default FileHasEnteteNotification; 