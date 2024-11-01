export class Chapitre {
  cours: {
    id?: number;
  };
  id?: number;
  titre?: string;
  resume?: string;

  constructor(
    cours: {
      id?: number;
    },
    id?: number,
    titre?: string,
    resume?: string,
  ) {
    this.id = id;
    this.titre = titre;
    this.resume = resume;
    this.cours = cours;
  }
}
