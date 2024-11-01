export class contenus {
  constructor(
    public chapitre: {
      id: number,
    },
    public titre?: string,
    public description?: string,
    public files?: []) {
  }
}

export class ContenuFiles { // Identifiant unique de la question (optionnel lors de la création)
  constructor(
    public contenu: {
      id: number
    },
    public files: {
      id: number
    },
  ) {};
}
