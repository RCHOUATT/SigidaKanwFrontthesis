import {Component, OnInit} from '@angular/core';
import {Utilisateur} from "../../../models/Utilisateur";
import {FilesService} from "../../../services/CrudServiceWithImage/Files.service";
import {NgClass} from "@angular/common";
import {FormsModule} from "@angular/forms";
import {shareService} from "../../../services/shareService";
import {
  CrudServiceWithoutImageService
} from "../../../services/CrudServiceWithoutImage/crud-service-without-image.service";

@Component({
  selector: 'app-liste-utilisateurs',
  standalone: true,
  imports: [
    NgClass,
    FormsModule
  ],
  templateUrl: './liste-utilisateurs.component.html',
  styleUrl: './liste-utilisateurs.component.scss'
})
export class ListeUtilisateursComponent implements OnInit {
  utilisateurs: Utilisateur[] = []; // Liste des utilisateurs
  activeUser = false;
  activeUserId: number | undefined = 0;
  user: any;

  //[ngClass]="{'active': activeUser}
  constructor(private service: CrudServiceWithoutImageService, private service1: shareService) {}

  ngOnInit(): void {
    this.loadUtilisateurs(); // Charge les utilisateurs lors de l'initialisation

  }
  loadUtilisateurs() {
    this.service.get("utilisateur").subscribe({
      next: (data) => {
        this.utilisateurs = data; // Remplit la liste des utilisateurs
        console.log(this.utilisateurs);
      },
      error: (err) => {
        console.error('Erreur lors du chargement des utilisateurs:', err);
      }
    });
  }

  setActive(activeUserId : any) {
    this.activeUser = true;
    this.activeUserId = activeUserId.id;
    localStorage.setItem("activeUserId", `${activeUserId}`);
    this.service1.updateFiles(activeUserId); // Ici, on envoie uniquement les fichiers eux-mêmes
  }

}
