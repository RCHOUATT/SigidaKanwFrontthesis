import {Component, CUSTOM_ELEMENTS_SCHEMA, OnInit} from '@angular/core';
import {ListeUtilisateursComponent} from "./liste-utilisateurs/liste-utilisateurs.component";
import {ListeBestUtilisateursComponent} from "./liste-best-utilisateurs/liste-best-utilisateurs.component";
import {PieChartComponent} from "../chart/pie-chart/pie-chart.component";
import {RouterLink, RouterOutlet} from "@angular/router";
import {shareService} from "../../services/shareService";
import {Utilisateur} from "../../models/Utilisateur";
import {ButtonComponent} from "../button/button.component";
import {BarChartComponent} from "../chart/bar-chart/bar-chart.component";
import {LoginService} from "../../services/login/login.service";

@Component({
  selector: 'app-utilisateurs',
  standalone: true,
  imports: [
    ListeUtilisateursComponent,
    ListeBestUtilisateursComponent,
    PieChartComponent,
    RouterOutlet,
    ButtonComponent,
    RouterLink,
    BarChartComponent
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  templateUrl: './utilisateurs.component.html',
  styleUrl: './utilisateurs.component.scss'
})
export class UtilisateursComponent implements OnInit{

  constructor(private service1: shareService,
              public loginService : LoginService,
              ) {}
  user: any; // Liste des utilisateurs

  ngOnInit(): void {
    this.service1.currentFiles.subscribe(files => {
      this.user = files;
      console.log("user : ", this.user);
    });
  }

  isDropdownOpen = false;

  pageActuelle: String = "Accueil";

  toggleDropdown() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  hideDropdown() {
    this.isDropdownOpen = false;
  }

  changerPageTitre(titre : String){
    this.pageActuelle = titre;
  }

}
