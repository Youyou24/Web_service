import EnteteFicheAnomalie from '../models/EnteteFicheAnomalie';
import DetailFicheAnomalie from '../models/DetailsFicheAnomalie';
import TypeAnomalie from '../models/TypeAnomalies';
import Anomalie from '../models/Anomalies';

export async function getFichesAnomalies() {
  const fiches = await EnteteFicheAnomalie.findAll({
    include: [
      {
        model: DetailFicheAnomalie,
        as: 'details',
        include: [
          {
            model: TypeAnomalie,
            as: 'typeAnomalie',
            include: [
              {
                model: Anomalie,
                as: 'anomalie',
              }
            ]
          }
        ]
      }
    ],
    order: [['createdAt', 'DESC']]
  });

  return fiches;
}
