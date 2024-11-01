import {NiveauEtudes} from "./NiveauEtudes";

export interface statUser {
  id?: number;       // Identifiant unique du rôle (optionnel lors de la création)
  point?: string;      // Nom du rôle (ex. "ADMIN", "USER")
  piece?: string;
  niveau?: NiveauEtudes // Nom du rôle (ex. "ADMIN", "USER")
}
