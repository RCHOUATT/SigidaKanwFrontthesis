import { Component, Input, Output, EventEmitter } from '@angular/core';
import {trash} from "ionicons/icons";

@Component({
  selector: 'app-button',
  templateUrl: './button.component.html',
  standalone: true,
  styleUrls: ['./button.component.scss']
})
export class ButtonComponent {

  // Propriétés dynamiques que vous pouvez passer au bouton
  @Input() label: string = 'Default';       // Le texte du bouton
  @Input() type: string = 'button';         // Le type de bouton (button, submit, reset)
  @Input() color: string = 'primary';       // Classe de couleur (ex: primary, secondary)
  @Input() disabled: boolean = false;       // Pour désactiver le bouton
  @Input() icon: string = '';               // Optionnel: une icône à ajouter au bouton
  @Input() largeur: string = '';              // Optionnel: une largeur à ajouter au bouton

  // Événement pour gérer le clic sur le bouton
  @Output() onClick = new EventEmitter<void>();

  // Méthode qui émet l'événement de clic
  handleClick() {
    if (!this.disabled) {
      this.onClick.emit();
    }
  }

  protected readonly trash = trash;
}
