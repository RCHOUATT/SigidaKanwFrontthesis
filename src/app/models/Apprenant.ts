import {Utilisateur} from "./Utilisateur";
import {NiveauEtudes} from "./NiveauEtudes";
import {StatsApprenant} from "./StatsApprenant";



export interface Apprenant extends Utilisateur {
  stats?: StatsApprenant; // Statistiques associées à l'apprenant (optionnel)
}
