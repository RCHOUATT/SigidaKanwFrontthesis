import 'package:flutter/material.dart';
import '../service/CrudServiceWithoutImage.dart';
import 'Utilisateur.dart';

// Cette classe est créée pour pouvoir accéder aux données du contextHolder
class UserProvider with ChangeNotifier {
  final CrudServiceWithoutImage service = CrudServiceWithoutImage();
  dynamic? _utilisateur; // Utilisateur est initialisé comme null

  dynamic? get utilisateur => _utilisateur;

  // Nouvelle méthode pour initialiser l'utilisateur
  Future<void> initializeUser(int id) async {
    if (_utilisateur == null) { // Vérifier si l'utilisateur a déjà été chargé
      try {
        _utilisateur = await service.findUser(id); // Attendre la réponse
        notifyListeners(); // Notifier les auditeurs après la mise à jour
      } catch (error) {
        print('Erreur lors de la récupération de l’utilisateur: $error');
      }
    }
  }

  // Setter pour l'utilisateur (si besoin de mise à jour)
  void setUtilisateur(dynamic utilisateur) {
    _utilisateur = utilisateur;
    notifyListeners();
  }
}
