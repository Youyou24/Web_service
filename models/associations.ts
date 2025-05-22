import EnteteFicheAnomalie from './EnteteFicheAnomalie';
import DetailFicheAnomalie from './DetailsFicheAnomalie';
import TypeAnomalie from './TypeAnomalies';
import Anomalie from './Anomalies';

// EnteteFicheAnomalie -> DetailFicheAnomalie
EnteteFicheAnomalie.hasMany(DetailFicheAnomalie, {
  foreignKey: 'fiche_id',
  as: 'detailsFiche', // changé ici
});
DetailFicheAnomalie.belongsTo(EnteteFicheAnomalie, {
  foreignKey: 'fiche_id',
  as: 'enteteFiche', // changé ici
});

// DetailFicheAnomalie -> TypeAnomalie
DetailFicheAnomalie.belongsTo(TypeAnomalie, {
  foreignKey: 'type_anomalie_id',
  as: 'typeAnomalieFromDetail',
});
TypeAnomalie.hasMany(DetailFicheAnomalie, {
  foreignKey: 'type_anomalie_id',
  as: 'detailAnomalies',
});

// TypeAnomalie -> Anomalie
TypeAnomalie.belongsTo(Anomalie, {
  foreignKey: 'anomalie_id',
  as: 'anomalieFromType', // alias unique ici
});
Anomalie.hasMany(TypeAnomalie, {
  foreignKey: 'anomalie_id',
  as: 'types',
});