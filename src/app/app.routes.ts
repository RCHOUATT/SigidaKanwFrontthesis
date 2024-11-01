import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: "home",
    loadComponent: () => import("./composants/home/home.component").then(m => m.HomeComponent)
  },
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  {
    path: "utilisateur",
    loadComponent: () => import("./composants/utilisateurs/utilisateurs.component").then(m => m.UtilisateursComponent)
  },
  {
    path: "ajouterUtilisateur",
    loadComponent: () => import("./composants/utilisateurs/ajouterUtilisateur/ajouterUtilisateur.component").then(m => m.AjouterUtilisateurComponent)
  },
  {
    path: "login",
    loadComponent: () => import("./composants/connexion/login/login.component").then(m => m.LoginComponent)
  },
  {
    path: "formation/culture",
    loadComponent: () => import("./composants/formations/culture/culture.component").then(m => m.CultureComponent)
  },
  {
    path: "formation/langue",
    loadComponent: () => import("./composants/formations/langue/langue.component").then(m => m.LangueComponent)
  },
  {
    path: "ajouterCours",
    loadComponent: () => import("./composants/formations/ajouterCours/ajouterCours.component").then(m => m.AjouterCoursComponent)
  },
  {
    path: "ajouterQuestion",
    loadComponent: () => import("./composants/formations/ajouter-question/ajouter-question.component").then(m => m.AjouterQuestionComponent)
  },
  {
    path: "ajouterContenu",
    loadComponent: () => import("./composants/formations/ajouter-contenu/ajouter-contenu.component").then(m => m.AjouterContenuComponent)
  },
  {
    path: "ajouterChapitre",
    loadComponent: () => import("./composants/formations/ajouter-chapitre/ajouter-chapitre.component").then(m => m.AjouterChapitreComponent)
  },
  {
    path: "appLanding",
    loadComponent: () => import("./landing/landing.component").then(m => m.LandingComponent)
  }
];
