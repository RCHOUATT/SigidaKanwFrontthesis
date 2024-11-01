import { Component } from '@angular/core';
import {NgClass} from "@angular/common";
import {shareService} from "../../services/shareService";

@Component({
  selector: 'app-files',
  templateUrl: './files.component.html',
  standalone: true,
  imports: [
    NgClass
  ],
  styleUrls: ['./files.component.scss']
})
export class FilesComponent {
  files: any[] = [];
  isDragging: boolean = false; // Pour gérer l'état de survol

  constructor(private service: shareService) {}

  triggerFileInput() {
    const fileInput = document.getElementById('fileInput') as HTMLInputElement;
    fileInput.click();
  }

  onFilesSelected(event: any) {
    const files = event.target.files;
    this.handleFiles(files);
  }

  onDragOver(event: DragEvent) {
    event.preventDefault();
    this.isDragging = true; // Activer l'état de survol
  }

  onDragLeave(event: DragEvent) {
    event.preventDefault();
    this.isDragging = false; // Désactiver l'état de survol
  }

  onFileDrop(event: DragEvent) {
    event.preventDefault();
    const files = event.dataTransfer?.files;
    if (files) {
      this.handleFiles(files);
    }
    this.isDragging = false; // Désactiver l'état de survol après le dépôt
  }

  removeFile(file: any) {
    this.files = this.files.filter(f => f !== file); // Supprime le fichier de la liste
  }


  // Gestion des fichiers sélectionnés
  /*handleFiles(files: FileList) {
    for (let i = 0; i < files.length; i++) {
      const file = files[i];

      // Vérification si la taille du fichier est correcte
      if (file.size > 0) {
        const fileURL = URL.createObjectURL(file);
        this.files.push({
          file: file,
          src: fileURL,
          type: file.type
        });
        this.service.updateFiles(this.files);
        console.log(this.files)
      } else {
        console.warn(`Le fichier ${file.name} est vide ou corrompu.`);
      }
    }
  }*/

  handleFiles(files: FileList) {
    const actualFiles: File[] = [];

    for (let i = 0; i < files.length; i++) {
      const file = files[i];

      // Vérification si la taille du fichier est correcte
      if (file.size > 0) {
        const fileURL = URL.createObjectURL(file);
        this.files.push({
          file: file,
          src: fileURL,
          type: file.type
        });

        // Ajout du fichier à la liste de fichiers réels à envoyer
        actualFiles.push(file);
      } else {
        console.warn(`Le fichier ${file.name} est vide ou corrompu.`);
      }
    }

    // Mise à jour des fichiers dans le service pour les envoyer
    this.service.updateFiles(this.files); // Ici, on envoie uniquement les fichiers eux-mêmes
    console.log(this.files); // Vous pouvez toujours afficher votre tableau personnalisé ici
  }

  // Vérification du type de fichier
  isImage(file: any): boolean {
    return file.type.split("/")[0] == "image";
    //return file.type.startsWith('image/');
  }

  isAudio(file: any): boolean {
    return file.type.split("/")[0] == "audio";
    //return file.type.startsWith('audio/');
  }

  isVideo(file: any): boolean {
    return file.type.split("/")[0] == "video";
    //return file.type.startsWith('video/');
  }
}
