import {Component, CUSTOM_ELEMENTS_SCHEMA, Input, OnInit} from '@angular/core';
import {ButtonComponent} from "../../button/button.component";
import {FilesComponent} from "../../files/files.component";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
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
import {Router, RouterLink} from "@angular/router";
import {Chapitre} from "../../../models/Chapitre";
import {LangueComponent} from "../langue/langue.component";

@Component({
  selector: 'app-ajouter-contenu',
  standalone: true,
  imports: [
    ButtonComponent,
    NgClass,
    FormsModule,
    FilesComponent,
    RouterLink,
  ],
  templateUrl: './ajouter-contenu.component.html',
  styleUrl: './ajouter-contenu.component.scss',
  schemas: [CUSTOM_ELEMENTS_SCHEMA],

})
export class AjouterContenuComponent implements OnInit{

  constructor(private location: Location,
              private service: CrudServiceWithoutImageService,
              private service2: CrudServiceWithImageService,
              private service1: shareService,
              public loginService: LoginService,
              public router: Router,
  ) {
  }

  ngOnInit() {
    this.authToken = sessionStorage.getItem("token")
    this.service1.currentFiles.subscribe(files => {
      this.files = files;
    });
    this.contenu.push(new contenus({id: 0}));
  }


  @Input() chapitre: Chapitre = {
    titre: "",
    cours: {
      id: 0
    },
    resume: "",
  };

  files: any[] = [];

  authToken: any;//le nombre d'élement(comme question pour les test ou contenu pour les chapitres) qui doit être ajouter à la page.
  contenu: any[] = [];//Liste d'element. Elle n'est utilisé que pour la boucle


  async Ajouter() {
    console.log(this.chapitre);
    console.log(this.contenu);
    //this.contenus.chapitre.id = data.id
    //pour ajouter les fichiers
    this.contenu.forEach(c => {
      this.service1.currentFiles.subscribe(files => {
        this.files = files;
      });
      console.log('contenuToBD : ', c);
      console.log("this.files", this.files);
      c.chapitre.id = this.chapitre.id;
      this.service2.creer('contenu', c, this.files)
        .subscribe(response => {
          console.log('Réponse : ', response);
        });
    });
  }
}
