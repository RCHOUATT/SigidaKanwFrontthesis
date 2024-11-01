import {Component, CUSTOM_ELEMENTS_SCHEMA} from '@angular/core';
import {RouterLink, RouterOutlet} from "@angular/router";
import {ButtonComponent} from "../composants/button/button.component";

@Component({
  selector: 'app-landing',
  standalone: true,
  imports: [
    RouterOutlet,
    RouterLink,
    ButtonComponent
  ],
  templateUrl: './landing.component.html',
  styleUrl: './landing.component.scss',
  schemas: [CUSTOM_ELEMENTS_SCHEMA] ,
})
export class LandingComponent {
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
