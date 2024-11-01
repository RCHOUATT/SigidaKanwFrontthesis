import { Instant } from 'js-joda';
import {Utilisateur} from "./Utilisateur"; // Assurez-vous d'utiliser js-joda ou une autre bibliothèque pour Instant

export interface ActiviteUtilisateur {
  id?: number;            // Identifiant unique de l'activité (optionnel lors de la création)
  dateUtilisation: Instant; // Date d'utilisation
  utilisateur: Utilisateur; // Utilisateur associé à cette activité
}
