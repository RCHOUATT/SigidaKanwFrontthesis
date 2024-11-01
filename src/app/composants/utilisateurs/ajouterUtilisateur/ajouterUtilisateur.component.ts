import {Component, CUSTOM_ELEMENTS_SCHEMA, OnInit} from '@angular/core';
import {ButtonComponent} from "../../button/button.component";
import {NgClass, Location} from "@angular/common";
import {
  CrudServiceWithoutImageService
} from "../../../services/CrudServiceWithoutImage/crud-service-without-image.service";
import {Cours} from "../../../models/Cours";
import {FormsModule} from "@angular/forms";
import {FilesComponent} from "../../files/files.component";
import {shareService} from "../../../services/shareService";
import {contenus} from "../../../models/Contenu";
import {Test} from "../../../models/Test";
import {CrudServiceWithImageService} from "../../../services/CrudServiceWithImage/crud-service-with-image.service";
import {Router, RouterLink} from "@angular/router";
import {LoginService} from "../../../services/login/login.service";
import {Utilisateur} from "../../../models/Utilisateur";

@Component({
  selector: 'app-ajouterUtilisateur',
  standalone: true,
  imports: [
    ButtonComponent,
    NgClass,
    FormsModule,
    FilesComponent,
    RouterLink,
  ],
  templateUrl: './ajouterUtilisateur.component.html',
  styleUrl: './ajouterUtilisateur.component.scss',
  schemas: [CUSTOM_ELEMENTS_SCHEMA],

})
export class AjouterUtilisateurComponent implements OnInit {
  constructor(private location: Location,
              private service: CrudServiceWithoutImageService,
              private service2: CrudServiceWithImageService,
              private service1: shareService,
              public loginService: LoginService,
              private router: Router
  ) {
  }

  ngOnInit() {
    this.loadRole();
    this.loadpays();
    this.loadNiveauEtudes();
    this.authToken = sessionStorage.getItem("token")
    this.service1.currentFiles.subscribe(files => {
      this.files = files;
    });
    this.contenu.push(new contenus({id: 0}));
  }

  utilisateur: Utilisateur = {
    adresse: "",
    dateBirthday: "",
    email: "",
    genreUser: undefined,
    id: 0,
    nom: "",
    password: "",
    pays: undefined,
    telephone: ""
  };

  cours: Cours = {
    titre: "",
    typeCours: {},
    langue: {},
    niveauEtudes: {},
    description: "",
  };

  chapitre = {
    titre: "",
    cours: {
      id: 0
    },
    resume: "",
  };

  test = new Test({id: 0}, {id: 0});
  files: any[] = [];
  roleToBd: string = "";

  isDropdownOpen = true;
  etat: number = 1;
  largeur: string = `width: calc((${this.etat} - 1) * 50%); transition: width 0.3s linear;`;
  role: any[] = [];
  pays: any[] = [];
  type: any;
  genreUser: any[] = [];
  authToken: any;contenu: any[] = [];

  stockerRole(role: any) {
    if (this.etat == 2) {
      this.roleToBd = this.role.find(data => data.role === role.value).role;
      console.log("this.utilisateur.role : ", this.roleToBd);
    }
  }

  stockerPays(pays: any) {
    this.utilisateur.pays = this.pays.find(data => data.pays === pays.value);
    console.log("this.utilisateur.pays", this.utilisateur.pays);
  }

  stockerGenreUser(genre: any) {
    this.utilisateur.genreUser = this.genreUser.find(data => data.genre === genre.value);
    console.log("this.utilisateur.genreUser : ", this.utilisateur.genreUser)
  }

  loadRole() {
    this.service.get("role").subscribe({
      next: (data) => {
        this.role = data; // Remplit la liste des utilisateurs
        this.roleToBd = this.role[0].role;
        console.log(this.roleToBd);
        console.log(this.role);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des roles:', err);
      }
    });
  };

  loadpays() {
    this.service.get("pays").subscribe({
      next: (data) => {
        this.pays = data; // Remplit la liste des utilisateurs
        this.utilisateur.pays = this.pays[0];
        console.log(this.utilisateur.pays);
        console.log(this.pays);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des pays:', err);
      }
    });
  };

  loadNiveauEtudes() {
    this.service.get("genre").subscribe({
      next: (data) => {
        console.log("role_data : " + this.genreUser);
        this.genreUser = data; // Remplit la liste des utilisateurs
        this.utilisateur.genreUser = this.genreUser[0];
        console.log(this.utilisateur.genreUser);
        console.log(this.genreUser);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des genres:', err);
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
    if (this.etat == 1) {
        this.changeEtatspositif();
    } else if (this.etat == 2) {
        this.changeEtatspositif();
    } else if (this.etat == 3) {
      this.service2.creerUser(this.roleToBd, 'utilisateur', this.utilisateur, this.files)
        .subscribe(response => {
          console.log('Réponse : ', response);
        });
      this.router.navigate(['/utilisateur']);
    }
  }

  goBack(): void {
    window.history.back();
  }

  isDropdownOpen1 = false;
  toggleDropdown1() {
    this.isDropdownOpen1 = !this.isDropdownOpen1;
  }

  hideDropdown1() {
    this.isDropdownOpen1 = false;
  }
}
