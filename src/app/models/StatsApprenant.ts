import {NiveauEtudes} from "./NiveauEtudes";

export interface StatsApprenant {
  id?: number;              // Identifiant unique des statistiques (optionnel lors de la création)
  point: number;            // Points de l'apprenant
  niveau: NiveauEtudes;     // Niveau d'études associé à ces statistiques
  // notifications?: Notification[]; // Liste des notifications (optionnelle)
}
