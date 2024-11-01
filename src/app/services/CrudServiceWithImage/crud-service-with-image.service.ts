import { Injectable } from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from "@angular/common/http";
import {catchError, Observable, throwError} from "rxjs";
import { Question } from "../../models/Question"; // Assurez-vous d'importer le modèle Question

@Injectable({
  providedIn: 'root'
})
export class CrudServiceWithImageService {

  public baseUrl = "http://localhost:8080/sigidaKanw";

  constructor(private http: HttpClient) {}

  headers = new HttpHeaders({
    'Authorization': `Bearer ${localStorage.getItem('token')}`
  });


  /**
   * Crée un objet existant.
   * @param {string} name - Le nom de l'entité (par exemple, 'question').
   * @param {T} entity - L'objet à créer.
   * @param {File[]} fichiers - Les fichiers à associer à l'entité.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  creer(name: string, entity: any, fichiers: { file: File; src: string; type: string }[]): Observable<any> {
    const formData = new FormData();
    formData.append('entity', JSON.stringify(entity)); // Convertit l'objet en chaîne JSON

    // Ajoute les fichiers au FormData s'ils existent
    if (fichiers && fichiers.length > 0) {
      fichiers.forEach(item => {
        if (item.file) { // Vérifie que 'file' existe
          formData.append('fichiers', item.file); // Ajoute le fichier
        }
      });
    }

    console.log(formData); // Pour le débogage

    return this.http.post<any>(`${this.baseUrl}/${name}/creer`, formData, { headers: this.headers });
  }


  /**
   * Crée un objet existant.
   * @param {string} name - Le nom de l'entité (par exemple, 'question').
   * @param {T} entity - L'objet à créer.
   * @param {File[]} fichiers - Les fichiers à associer à l'entité.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  creerUser(roleToBd: string, name: string, entity: any, fichiers?: { file: File; src: string; type: string }[]): Observable<any> {
    const formData = new FormData();
    formData.append('utilisateurJson', JSON.stringify(entity)); // Convertit l'objet en chaîne JSON

    // Ajoute les fichiers au FormData s'ils existent
    if (fichiers && fichiers.length > 0) {
      fichiers.forEach(item => {
        if (item.file) { // Vérifie que 'file' existe
          formData.append('image', item.file); // Ajoute le fichier
        }
      });
    }

    console.log(formData); // Pour le débogage

    return this.http.post<any>(`${this.baseUrl}/${name}/inscrireUser/${roleToBd}`, formData, { headers: this.headers });
  }

  /**
   * Modifie une entité existante.
   * @param {string} name - Le nom de l'entité.
   * @param {number} id - L'ID de l'entité à modifier.
   * @param {T} entity - Les nouvelles données de l'entité.
   * @param {File[]} fichiers - Les fichiers à associer à l'entité.
   * @return {Observable<any>} Un observable qui émet la réponse du serveur.
   */
  modifier<T>(name: string, id: number, entity: T, fichiers: File[]): Observable<any> {
    const formData = new FormData();
    formData.append('entity', JSON.stringify(entity)); // Convertit l'objet en chaîne JSON

    // Ajoute les fichiers au FormData s'ils existent
    if (fichiers) {
      fichiers.forEach(file => {
        formData.append('fichiers', file);
      });
    }

    return this.http.patch<any>(`${this.baseUrl}/${name}/Modifier/${id}`, formData); // Appel à l'API
  }

  /**
   * Récupère toutes les entités.
   * @param {string} name - Le nom de l'entité.
   * @return {Observable<any[]>} Un observable qui émet la liste des entités.
   */
  getObject(name: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/${name}/Afficher`); // Appel à l'API
  }

  /**
   * Supprime une entité.
   * @param {string} name - Le nom de l'entité.
   * @param {number} id - L'ID de l'entité à supprimer.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  supprimer(name: string, id: number): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/${name}/Supprimer/${id}`); // Appel à l'API
  }

  /**
   * Supprime plusieurs entités.
   * @param {string} name - Le nom de l'entité.
   * @param {number[]} ids - La liste des IDs à supprimer.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  supprimerPlusieurs(name: string, ids: number[]): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/${name}/SupprimerPlusieurs`, { body: ids }); // Appel à l'API
  }

  /**
   * Supprime toutes les entités.
   * @param {string} name - Le nom de l'entité.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  supprimerTous(name: string): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/${name}/SupprimerAll`); // Appel à l'API
  }
}
