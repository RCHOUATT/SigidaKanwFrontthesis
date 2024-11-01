import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {Observable, tap} from "rxjs";
import {Router} from "@angular/router";

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  private apiUrl = 'http://localhost:8080/sigidaKanw/api/auth/login';

  constructor(private http: HttpClient, private router:Router) { }

  login(email: string, password: string): Observable<any> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    const body = JSON.stringify({ email, password });

    return this.http.post(this.apiUrl, body, { headers })
      .pipe(
        tap(response => {
          // Gérer la réponse ici, par exemple, stocker le token d'authentification
          console.log('Login successful', response);
        })
      );
  }


  logout(): void {
    // Supprimer le token du localStorage
    localStorage.removeItem('token');

    // Rediriger vers la page de connexion ou une autre page
    this.router.navigate(['/login']);
  }

  isAuthenticated(): boolean {
    const token = localStorage.getItem('token');
    if (!token) return false;

    // Décodez le token (s'il est JWT) pour vérifier la date d'expiration
    const payload = JSON.parse(atob(token.split('.')[1])); // Décodage de la charge utile
    const currentTime = Date.now() / 1000; // Temps actuel en secondes

    console.log("payload.exp", payload.exp);
    console.log("currentTime", currentTime);
    // Vérifiez si le token est expiré
    return payload.exp > currentTime;
  }


}
