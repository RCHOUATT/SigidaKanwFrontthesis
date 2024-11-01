import {Files} from "./Files";
import {RoleUser} from "./RoleUser";
import {statUser} from "./statUser";
import {GenreUser} from "./GenreUser";

export interface Utilisateur {
  id?: number;              // Identifiant unique de l'utilisateur (optionnel lors de la création)
  nom: string;              // Nom de l'utilisateur
  email: string;            // Email de l'utilisateur, unique et requis
  telephone?: string;       // Numéro de téléphone de l'utilisateur (optionnel)
  password: string;              // Mot de passe de l'utilisateur, requis
  pays?: {
    id?: number;
    pays?: string;
  };
  role?: RoleUser;           // Rôle associé à l'utilisateur
  stats?: statUser;           // Rôle associé à l'utilisateur
  files?: Files;      // Numéro de téléphone de l'utilisateur (optionnel)
  dateBirthday?: string;    // Date de naissance de l'utilisateur (optionnel)
  adresse?: string;         // Adresse de l'utilisateur (optionnel)
  genreUser?: GenreUser;  // Fichier associé à l'utilisateur (optionnel)
}
