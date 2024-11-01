import {Component, CUSTOM_ELEMENTS_SCHEMA, Input, input, OnInit} from '@angular/core';
import {Location, NgClass} from "@angular/common";
import {
  CrudServiceWithoutImageService
} from "../../../services/CrudServiceWithoutImage/crud-service-without-image.service";
import {CrudServiceWithImageService} from "../../../services/CrudServiceWithImage/crud-service-with-image.service";
import {shareService} from "../../../services/shareService";
import {LoginService} from "../../../services/login/login.service";
import {ReponsePossible} from "../../../models/ReponsePossible";
import {Question, QuestionFiles} from "../../../models/Question";
import {ContenuFiles, contenus} from "../../../models/Contenu";
import {Cours} from "../../../models/Cours";
import {Test} from "../../../models/Test";
import {ButtonComponent} from "../../button/button.component";
import {FormsModule} from "@angular/forms";
import {FilesComponent} from "../../files/files.component";
import {RouterLink} from "@angular/router";

@Component({
  selector: 'app-ajouter-question',
  standalone: true,
  imports: [
    ButtonComponent,
    NgClass,
    FormsModule,
    FilesComponent,
    RouterLink,
  ],
  templateUrl: './ajouter-question.component.html',
  styleUrl: './ajouter-question.component.scss',
  schemas: [CUSTOM_ELEMENTS_SCHEMA],

})
export class AjouterQuestionComponent implements OnInit{
  constructor(private location: Location,
              private service: CrudServiceWithoutImageService,
              private service2: CrudServiceWithImageService,
              private service1: shareService,
              public loginService: LoginService,
  ) {
  }

  ngOnInit() {
    this.loadTypeCours();
    this.loadlangues();
    this.loadNiveauEtudes();
    this.loadTypeTest();
    this.authToken = sessionStorage.getItem("token")
    this.service1.currentFiles.subscribe(files => {
      this.files = files;
    });
    this.questions.push({
      nbreReponsePossible: 1,
      reponsePossible: [new ReponsePossible({id: 0})],
      question: new Question({id: 0})
    });
    this.contenu.push(new contenus({id: 0}));
  }

  @Input() testId: number = 0
  cours: Cours = {
    titre: "",
    typeCours: {},
    langue: {},
    niveauEtudes: {},
    description: "",
  };
  questionFile: QuestionFiles = {
    question: {
      id: 0,
    },
    files: {
      id: 0,
    }
  }

  contenuFile: ContenuFiles = {
    contenu: {
      id: 0,
    },
    files: {
      id: 0,
    }
  }

  chapitre = {
    titre: "",
    cours: {
      id: 0
    },
    resume: "",
  };

  //contenus : contenus = new contenus();

  questionToBd: {
    question: string,
    reponseCorrecte: string,
    test: any,
  } = {
    question: "",
    reponseCorrecte: "",
    test: {
      id: 0
    },
  };

  reponsePossibleToBd = {
    reponsePossible: "",
    question: {
      id: 0,
    }
  }

  test = new Test({id: 0}, {id: 0});
  files: any[] = [];

  isDropdownOpen = true;
  etat: number = 1;
  largeur: string = `width: calc((${this.etat} - 1) * 50%); transition: width 0.3s linear;`;
  typeCours: any[] = [];
  typeTest: any[] = [];
  langue: any[] = [];
  type: any;
  niveauEtudes: any[] = [];
  niveau: any;
  authToken: any;
  nbreContenu = 1;//le nombre d'élement(comme question pour les test ou contenu pour les chapitres) qui doit être ajouter à la page.
  nbreQuestion = 1;//le nombre d'élement(comme question pour les test ou contenu pour les chapitres) qui doit être ajouter à la page.
  contenu: any[] = [];//Liste d'element. Elle n'est utilisé que pour la boucle
  nbreReponsePossible = 1;//le nombre d'élement(comme question pour les test ou contenu pour les chapitres) qui doit être ajouter à la page.
  reponsePossible = "";//Liste d'element. Elle n'est utilisé que pour la boucle

  //question={nbreReponsePossible: 1, reponsePossible: [this.reponsePossible], reponseCorrecte: "",}
  questions: any[] = [];

  incrementNbreElment() {
    if (this.nbreContenu < 10 && this.etat == 2) {
      this.nbreContenu++;
      //this.contenu = Array(this.nbreContenu).fill(0).map((idx, i) => i);
      this.contenu.push(new contenus({id: 0}));
      console.log(this.contenu);
    } else if (this.nbreQuestion < 10 && this.etat == 3) {
      this.nbreQuestion++;
      this.questions.push({
        nbreReponsePossible: 1,
        reponsePossible: [new ReponsePossible({id: 0})],
        question: new Question({id: 0})
      });
      console.log(this.questions);
    }
  }


  incrementNbreReponse(question: any) {
    console.log("question : ", this.questions[question])
    console.log("index : ", question)
    if (this.questions[question].nbreReponsePossible < 10) {
      this.nbreReponsePossible++;
      this.questions[question].nbreReponsePossible++;
      console.log("question nbreRepo : ", this.questions[question].nbreReponsePossible)
      this.questions[question].reponsePossible.push(new ReponsePossible({id: 0}));
      console.log("question RepoPoss : ", this.questions[question].reponsePossible);
      console.log("question modifié : ", this.questions[question]);
      console.log("Liste questions : ", this.questions);
    }
  }

  decrementNbreElment() {
    if (this.nbreContenu <= 10 && this.nbreContenu > 1 && this.etat == 2) {
      this.nbreContenu--;
      this.contenu = Array(this.nbreContenu).fill(0).map((idx, i) => i);
      console.log(this.contenu);
    } else if (this.nbreQuestion <= 10 && this.nbreQuestion > 1 && this.etat == 3) {
      this.nbreQuestion--;
      this.questions.pop();
      console.log(this.questions);
    }
  }

  decrementNbreReponse(question: any) {
    if (this.questions[question].nbreReponsePossible <= 10 && this.questions[question].nbreReponsePossible > 1) {
      this.nbreReponsePossible--;
      this.questions[question].reponsePossible.pop();
      console.log(this.questions[question].reponsePossible);
    }
  }

  stockerType(t: any) {
    if (this.etat == 1) {
      this.cours.typeCours = this.typeCours.find(data => data.type === t.value);
      console.log(this.cours.typeCours);
    }
    if (this.etat == 3) {
      this.test.typeTest = this.typeTest.find(data => data.type === t.value);
      console.log(this.test.typeTest)
    }
  }

  stockerLangue(t: any) {
    this.cours.langue = this.langue.find(data => data.nom === t.value);
    console.log("this.cours.langue", this.cours.langue);
  }

  stockerNiveau(n: any) {
    this.cours.niveauEtudes = this.niveauEtudes.find(data => data.niveau === n.value);
    console.log(this.cours.niveauEtudes)
  }

  loadTypeCours() {
    this.service.get("typeCours").subscribe({
      next: (data) => {
        this.typeCours = data; // Remplit la liste des utilisateurs
        this.cours.typeCours = this.typeCours[0];
        console.log(this.cours.typeCours);
        console.log(this.typeCours);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des types:', err);
      }
    });
  };

  loadlangues() {
    this.service.get("langue").subscribe({
      next: (data) => {
        this.langue = data; // Remplit la liste des utilisateurs
        this.cours.langue = this.langue[0];
        console.log(this.cours.langue);
        console.log(this.langue);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des types:', err);
      }
    });
  };

  loadTypeTest() {
    this.service.get("typeTests").subscribe({
      next: (data) => {
        this.typeTest = data; // Remplit la liste des utilisateurs
        this.test.typeTest = this.typeTest[0];
        console.log(this.test.typeTest);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des types:', err);
      }
    });
  };

  loadNiveauEtudes() {
    this.service.get("niveauEtudes").subscribe({
      next: (data) => {
        console.log("Niveau_data : " + this.niveauEtudes);
        this.niveauEtudes = data; // Remplit la liste des utilisateurs
        this.cours.niveauEtudes = this.niveauEtudes[0];
        console.log(this.cours.niveauEtudes);
        console.log(this.niveauEtudes);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des niveaux:', err);
      }
    });
  };

  changeEtatspositif() {
    console.log("avant :" + this.etat)
    if (this.etat >= 1 && this.etat < 3) {
      ++this.etat;
    }
    console.log(this.etat)
    this.largeur = `width: calc((${this.etat} - 1) * 50%) ; transition: width 0.3s linear;`;

  }

  changeEtatsnegatif() {
    console.log("avant :" + this.etat)
    if (this.etat > 1) {
      this.etat--;
    }
    console.log(this.etat)
    this.largeur = `width: calc((${this.etat} - 1) * 50%) ; transition: width 0.3s linear;`;
  }

  back() {
    this.location.back();  // This will navigate to the previous page in the browser history
  }

  async Ajouter() {
    this.questions.forEach(q => {
      q.question.test.id = this.testId;
      console.log("question", this.questions);
      this.service1.currentFiles.subscribe(files => {
        this.files = files;
      });
      this.service2.creer('question', q.question, this.files)
        .subscribe(response => {
          q.reponsePossible.forEach((r: ReponsePossible) => {
            r.question.id = response.id;
            console.log("reponseToBack : ", r);
            console.log("question from Back : ", response);
            this.service.post('reponsePossible', r, this.authToken)
              .subscribe(response => {
                console.log('Réponse : ', response);
              });
          })
          console.log('Réponse : ', response);
        });
    });
  }

  goBack(): void {
    window.history.back();
  }

  isDropdownOpen1 = false;

  pageActuelle: String = "Accueil";

  toggleDropdown1() {
    this.isDropdownOpen1 = !this.isDropdownOpen1;
  }

  hideDropdown1() {
    this.isDropdownOpen1 = false;
  }

  changerPageTitre(titre: String) {
    this.pageActuelle = titre;
  }
}
