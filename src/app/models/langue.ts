export class langue {
  id?: number;        // Identifiant unique de la langue (optionnel lors de la création)
  nom?: string;     // Nom du niveau d'études (ex. "Licence", "Master")
  apropos?: string;


  constructor(id?: number, nom?: string, apropos?: string) {
    this.id = id;
    this.nom = nom;
    this.apropos = apropos;
  }
}
