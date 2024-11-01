export class Cours {
  id?: number;
  titre?: string;
  description?: string;
  niveauEtudes?: {};
  typeCours?: {};
  langue?: {};
  utilisateur?: {};

  constructor(
    id?: number,
    titre?: string,
    description?: string,
    niveauEtudes?: {},
    typeCours?: {},
    langue?: {},
    utilisateur?: {}
  ) {
    this.id = id;
    this.titre = titre;
    this.description = description;
    this.niveauEtudes = niveauEtudes;
    this.typeCours = typeCours;
    this.langue = langue;
    this.utilisateur = utilisateur;
  }
}
