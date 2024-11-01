import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Files} from "../models/Files";// Assurez-vous d'importer le modèle Files

@Injectable({
  providedIn: 'root'
})
export class FilesService {
  private baseUrl = "http://localhost:8080/sigidaKanw/files"; // URL de base de l'API

  constructor(private http: HttpClient) {}

  /**
   * Télécharge un fichier sur le serveur.
   *
   * @param {File} file - Le fichier à uploader.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  uploadFile(file: File): Observable<string> {
    const formData = new FormData();
    formData.append('file', file); // Ajoute le fichier au FormData

    return this.http.post<string>(`${this.baseUrl}/uploadFiles`, formData); // Appel à l'API pour uploader le fichier
  }

  /**
   * Met à jour un fichier existant sur le serveur.
   *
   * @param {number} id - L'ID du fichier à modifier.
   * @param {File} file - Le nouveau fichier.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  updateFile(id: number, file: File): Observable<string> {
    const formData = new FormData();
    formData.append('file', file); // Ajoute le fichier au FormData

    return this.http.patch<string>(`${this.baseUrl}/update/${id}`, formData); // Appel à l'API pour modifier le fichier
  }

  /**
   * Récupère tous les fichiers du serveur.
   *
   * @return {Observable<Files[]>} Un observable qui émet la liste des fichiers.
   */
  getAllFiles(): Observable<Files[]> {
    return this.http.get<Files[]>(`${this.baseUrl}/AfficherFiles`); // Appel à l'API pour récupérer tous les fichiers
  }

  /**
   * Récupère un fichier spécifique par ID.
   *
   * @param {number} id - L'ID du fichier à récupérer.
   * @return {Observable<Files>} Un observable qui émet le fichier récupéré.
   */
  getFileById(id: number): Observable<Files> {
    return this.http.get<Files>(`${this.baseUrl}/AfficherFile?id=${id}`); // Appel à l'API pour récupérer un fichier
  }

  /**
   * Supprime un fichier par ID.
   *
   * @param {number} id - L'ID du fichier à supprimer.
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  deleteFile(id: number): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/delete/${id}`); // Appel à l'API pour supprimer le fichier
  }

  /**
   * Supprime tous les fichiers sur le serveur.
   *
   * @return {Observable<string>} Un observable qui émet la réponse du serveur.
   */
  deleteAllFiles(): Observable<string> {
    return this.http.delete<string>(`${this.baseUrl}/deleteAll`); // Appel à l'API pour supprimer tous les fichiers
  }
}
