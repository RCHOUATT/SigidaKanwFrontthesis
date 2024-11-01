import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class CrudServiceWithoutImageService {

  public baseUrl = "/sigidaKanw";
  public baseUrl1 = "http://localhost:8081/sigidaKanw";

  constructor(private http: HttpClient) {}

  headers = new HttpHeaders({
    'Authorization': `Bearer ${localStorage.getItem('token')}`
  });

  /**
   * Récupère des données à partir d'un point de terminaison spécifié.
   *
   * @param {string} name - Le nom du point de l'endpoint.
   * @return {Observable<any>} Un observable qui émet les données récupérées.
   */
  get(name: string): Observable<any> {
    return this.http.get(`${this.baseUrl}/${name}/Afficher`, {headers: this.headers});
  }

  /**
   * Envoie une requête POST à l'endpoint spécifié pour créer une nouvelle ressource.
   *
   * @param {string} name - Le nom de l'endpoint general.
   * @param {any} object - Les données à envoyer dans le corps de la requête.
   * @return {Observable<Object>} Un observable qui émet la réponse du serveur.
   */
  post(name: string, object: any, authHeader: any): Observable<any> {
    const headers = new HttpHeaders({
      'Authorization': 'Basic ' + authHeader})
    return this.http.post(`${this.baseUrl}/${name}/Ajouter`, object, {headers: this.headers});
  }


  /**
   * Met à jour un objet dans la collection spécifiée.
   *
   * @param {string} name - Le nom de l'endpoint.
   * @param {number} id - L'ID de l'objet à mettre à jour.
   * @param {Object} object - L'objet mis à jour.
   * @return {Observable<Object>} Un observable qui émet l'objet mis à jour.
   */
  update(name: string,id: number, object: Object): Observable<Object> {
    return this.http.put(`${this.baseUrl}/${name}/Modifier/${id}`, object, {headers: this.headers});
  }


  active(name: string, id: number, object: Object): Observable<Object> {
    return this.http.patch(`${this.baseUrl}/${name}/${id}`, object, {headers: this.headers});
  }


  /**
   * Supprime un objet d'une collection spécifiée.
   *
   * @param {string} name - Le nom de l'endpoint .
   * @param {number} id - L'ID de l'objet à supprimer.
   * @return {Observable<any>} Un observable qui émet la réponse du serveur.
   */
  delete(name: string,id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl1}/${name}/Supprimer/${id}`, {headers: this.headers});
  }

  /**
   * Supprime plusieurs entités.
   *
   * @param {String} name - L'ID de la question à supprimer.
   * @param {number} id - L'ID de la question à supprimer.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  supprimerPlusieurs(id: [], name: String): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/${name}/SupprimerPlusieur/${id}`, {headers: this.headers}); // Appel à l'API pour supprimer la question
  }

  /**
   * Supprime tous les entités.
   *
   * @param {String} name - L'ID de la question à supprimer.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  supprimerTous(name: String): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/${name}/SupprimerAll`, {headers: this.headers}); // Appel à l'API pour supprimer la question
  }
}
