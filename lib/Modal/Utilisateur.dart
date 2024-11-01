import 'GenreUser.dart';
import 'Langues.dart';
import 'Pays.dart';

class Utilisateur {
  int? id;
  String? nom;
  Pays? pays;
  String? email;
  DateTime? dateBirthday;
  String? adresse;
  String? telephone;
  String? password;
  dynamic? role; // Assurez-vous que vous savez comment sérialiser cela
  GenreUser? genreUser;
  dynamic? files; // Assurez-vous que vous savez comment sérialiser cela
  List<dynamic> langues;

  Utilisateur({
    this.id,
    this.nom,
    this.pays,
    this.email,
    this.dateBirthday,
    this.adresse,
    this.telephone,
    this.password,
    this.role,
    this.genreUser,
    this.files,
    List<dynamic>? langues,
  }) : this.langues = langues ?? []; // Initialize to an empty list if null

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'pays': pays?.toJson(),
      'email': email,
      'dateBirthday': dateBirthday?.toIso8601String(),
      'adresse': adresse,
      'telephone': telephone,
      'password': password,
      'role': role, // Assurez-vous que cela est sérialisable
      'genreUser': genreUser?.toJson(),
      'files': files, // Assurez-vous que cela est sérialisable
      'langues': langues.map((l) => l.toJson()).toList(),
    };
  }

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      nom: json['nom'],
      pays: json['pays'] != null ? Pays.fromJson(json['pays']) : null,
      email: json['email'],
      dateBirthday: json['dateBirthday'] != null ? DateTime.tryParse(json['dateBirthday']) : null,
      adresse: json['adresse'],
      telephone: json['telephone'],
      password: json['password'],
      role: json['role'], // Assurez-vous que cela est désérialisable
      genreUser: json['genreUser'] != null ? GenreUser.fromJson(json['genreUser']) : null,
      files: json['files'], // Assurez-vous que cela est désérialisable
      langues: json['langues'] != null
          ? (json['langues'] as List).map((e) => Langues.fromJson(e)).toList()
          : [], // Ensure it's initialized to an empty list if null
    );
  }
}
