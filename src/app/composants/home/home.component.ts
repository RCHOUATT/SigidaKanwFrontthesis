import {Component, CUSTOM_ELEMENTS_SCHEMA} from '@angular/core';
import {BarChartComponent} from "../chart/bar-chart/bar-chart.component";
import {UtilisateursComponent} from "../utilisateurs/utilisateurs.component";
import {ListeUtilisateursComponent} from "../utilisateurs/liste-utilisateurs/liste-utilisateurs.component";
import {
  ListeBestUtilisateursComponent
} from "../utilisateurs/liste-best-utilisateurs/liste-best-utilisateurs.component";
import {PieChartComponent} from "../chart/pie-chart/pie-chart.component";
import {ButtonComponent} from "../button/button.component";
import {RouterLink, RouterOutlet} from "@angular/router";
import {LoginService} from "../../services/login/login.service";

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [
    BarChartComponent,
    UtilisateursComponent,
    ListeUtilisateursComponent,
    ListeBestUtilisateursComponent,
    PieChartComponent,
    ButtonComponent,
    RouterOutlet,
    RouterLink
  ],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss',
  schemas: [CUSTOM_ELEMENTS_SCHEMA] ,

})
export class HomeComponent {
  isDropdownOpen = false;

  constructor(
    public loginService : LoginService,
  ) {
  }

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
