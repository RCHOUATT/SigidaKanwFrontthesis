import {Component, OnInit} from '@angular/core';
import {Router, RouterLink, RouterOutlet} from "@angular/router";
import {FormsModule} from "@angular/forms";
import {ButtonComponent} from "../../button/button.component";
import {LoginService} from "../../../services/login/login.service";

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    RouterLink,
    RouterOutlet,
    FormsModule,
    ButtonComponent
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss'
})
export class LoginComponent implements OnInit{

  constructor(private router: Router, private service: LoginService) {
  }

  ngOnInit(): void {
    this.tocken = localStorage.getItem('token');
  }

  navigateToAppLanding() {
    this.router.navigate(['/appLanding']);
  }

  tocken : String | null = "";
  email = "";
  password = "";
  visible= false;

  logIn() {
    console.log(this.email, this.password)
    this.service.login(this.email, this.password).subscribe(
      response => {
        // Gérer le succès ici, par exemple, rediriger l'utilisateur
        console.log('Login successful', response);
        if(response.accessToken){
          localStorage.setItem('token', response.accessToken);
          this.router.navigate(['/home']);
        };
      },
      error => {
        // Gérer les erreurs ici
        console.error('Login failed', error);
      }
    );
  }

}
