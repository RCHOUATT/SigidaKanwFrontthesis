export class Test {
  public chapitre: {
    id: number,
  };    // Chapitre associé au test
  public typeTest: {
    id: number,
  };
  public id?: number;           // Identifiant unique du test (optionnel lors de la création)
  public titre?: string;       // Titre du test
  public description?: string;    // Description du test
  public nbrePoint?: number;
  constructor(
    chapitre: {
      id: number,
    },      // Chapitre associé au test
    typeTest: {
      id: number,
    },
    id?: number,             // Identifiant unique du test (optionnel lors de la création)
    titre?: string,         // Titre du test
    description?: string,    // Description du test
    nbrePoint?: number,// Utilisateur (enseignant) associé au test
    ){
    this.chapitre = chapitre;
    this.typeTest = typeTest;
  }     // Type de test associé
}
