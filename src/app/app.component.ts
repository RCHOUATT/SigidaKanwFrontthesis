import {Component, CUSTOM_ELEMENTS_SCHEMA, OnDestroy, OnInit} from '@angular/core';
import {RouterLink, RouterOutlet} from '@angular/router';
import {ButtonComponent} from "./composants/button/button.component";
import {Router} from "@angular/router";
import {LoginComponent} from "./composants/connexion/login/login.component";
import {LoginService} from "./services/login/login.service";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterLink, ButtonComponent, LoginComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
  schemas: [CUSTOM_ELEMENTS_SCHEMA] ,
})
export class AppComponent implements OnInit/*, OnDestroy*/{
  title = 'sigidaKanw';
  tockenActive :any;
  private intervalId: any;

  constructor(private authService: LoginService, private router: Router) {}

  ngOnInit(): void {
    if (this.authService.isAuthenticated()) {
      console.log('User is authenticated');
      this.router.navigate(['/home']); // Rediriger vers la page de connexion
      // Vous pouvez rediriger l'utilisateur vers une page protégée ici
    } else {
      console.log('User is not authenticated');
      this.router.navigate(['/login']); // Rediriger vers la page de connexion
    };
    /*this.checkToken();
    if (this.tockenActive)
    {
      this.intervalId = setInterval(()=>{
        this.tockenActive = this.authService.isAuthenticated();
        console.log(this.tockenActive)
      }, 1000);
    }
    if (!this.tockenActive) {
      alert("Le token est expiré. Déconnexion...");
      this.authService.logout(); // Déconnexion de l'utilisateur
      clearInterval(this.intervalId);
    }*/
  }

  /*checkToken(){
    this.tockenActive = this.authService.isAuthenticated();
  }

  ngOnDestroy() {
    clearInterval(this.intervalId); // Nettoyer l'intervalle lorsque le composant est détruit
  }*/
}


