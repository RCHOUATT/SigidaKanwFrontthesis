import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class shareService {
  // Utilisation de BehaviorSubject pour garder la trace des fichiers
  private filesSource = new BehaviorSubject<any[]>([]);
  currentFiles = this.filesSource.asObservable();

  constructor() {}

  // Fonction pour mettre à jour les fichiers
  updateFiles(files: any[]) {
    this.filesSource.next(files);
  }
}
