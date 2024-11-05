import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';

import 'AuthService.dart';


class CrudServiceWithoutImage {
  final String apiUrl = 'http://localhost:8081/sigidaKanw'; // URL de ton API backend
  final String apiUrl1 = 'http://localhost:8080/sigidaKanw'; // URL de ton API backend
  final AuthService _authService = AuthService();

  Future<dynamic> getStat(String endpoint, int id) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$endpoint/Afficher/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Décodage de la réponse JSON et création d'une instance `Utilisateur`
        print( jsonDecode(response.body));
        return jsonDecode(response.body); response.body;
      } else {
        print('Erreur: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors du chargement: $e');
      return null;
    }

  }

  Future<dynamic?> findUser(int? id) async {
    try {
      final response = await http.get(
        Uri.parse("$apiUrl/utilisateur/User/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Décodage de la réponse JSON et création d'une instance `Utilisateur`
        print( jsonDecode(response.body));
        return jsonDecode(response.body); response.body;
      } else {
        print('Erreur: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors du chargement: $e');
      return null;
    }
  }

  Stream<List<dynamic>> getdata(String endpoint,) async* {
    final response = await http.get(Uri.parse('$apiUrl/$endpoint/Afficher'));
    if (response.statusCode == 200) {
      yield jsonDecode(response.body);
    } else {
      throw Exception('Element non trouvé');
    }
  }

  Stream<List<dynamic>> getCours(String endpoint,) async* {
    final response = await http.get(Uri.parse('$apiUrl1/$endpoint/Afficher'));
    if (response.statusCode == 200) {
      yield jsonDecode(response.body);
    } else {
      throw Exception('Element non trouvé');
    }
  }

  Stream<List<dynamic>> getNiveau(String endpoint,) async* {
    final response = await http.get(Uri.parse('$apiUrl1/$endpoint/Afficher'));
    if (response.statusCode == 200) {
      yield jsonDecode(response.body);
    } else {
      throw Exception('Element non trouvé');
    }
  }

  Future<dynamic?> modifierStatistiques(int id, int point, int piece) async {
    final String apiUrl = 'http://localhost:8081/sigidaKanw/stat/Modifier/$id';

    // Création du corps de la requête
    final Map<String, dynamic> body = {
      "point": point,
      "piece": piece,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body), // Sérialisation de l'objet en JSON
      );

      if (response.statusCode == 200) {
        return response.statusCode;
        print('Statistiques mises à jour avec succès.');
      } else {
        print('Échec de la mise à jour : ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }
  /*Future<List<dynamic>> getdata(String endpoint,) async {
    final response = await http.get(Uri.parse('$apiUrl/$endpoint/Afficher'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception('Produit non trouvé');
    }
  }*/

  Future<dynamic?> post(String endpoint, Object objet) async {
    try {
      // Sérialisation de l'objet en JSON
      final String jsonBody = jsonEncode(objet);

      // Envoi de la requête POST
      final response = await http.post(
        Uri.parse('$apiUrl/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json', // JSON car on envoie des données sérialisées
          'Accept': 'application/json',
        },
        body: jsonBody, // Envoi du JSON sérialisé
      );

      // Vérification du code de réponse
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Inscription réussie: ${response.statusCode}');
        return response.statusCode; // Retourne le code de succès
      } else {
        print('Échec de la connexion: ${response.statusCode}, ${response.body}');
        return null; // Retourne null en cas d'échec
      }
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      return null; // Retourne null en cas d'erreur d'exécution
    }
  }

  Future<dynamic?> creerCompte(String endpoint, Object objet, {File? image}) async {
    try {
      // Sérialisation de l'objet en JSON
      final String jsonBody = jsonEncode(objet);
      print(jsonBody);

      // Création d'un multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/$endpoint'),
      );

      // Ajout des headers (le Content-Type sera géré par MultipartRequest)
      request.headers['Accept'] = 'application/json';

      // Ajout de l'objet JSON en tant que champ 'apprenant'
      request.fields['apprenant'] = jsonBody;

      // Ajout de l'image si elle existe
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image', // Nom du paramètre attendu par le serveur
          image.path,
        ));
      }

      // Envoi de la requête
      final response = await request.send();

      // Vérification du code de réponse
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Inscription réussie: ${response.statusCode}');
        return response.statusCode; // Retourne le code de succès
      } else {
        // Lire la réponse du serveur
        final responseBody = await response.stream.bytesToString();
        print('Échec de la connexion: ${response.statusCode}, $responseBody');
        return null; // Retourne null en cas d'échec
      }
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      return null; // Retourne null en cas d'erreur d'exécution
    }
  }
  Future<dynamic?> UpdateUser(Object objet, {File? image}) async {
    try {
      //Obtention de l'Id de l'utilisateur connecté
      String? token = await _authService.getToken();
      final userId = await _authService.getUserIdFromToken(token!); // Méthode pour récupérer le rôle
      // Sérialisation de l'objet en JSON
      final String jsonBody = jsonEncode(objet);
      print(jsonBody);

      // Création d'un multipart request
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$apiUrl/utilisateur/ModifierApprenat/$userId'),
      );

      // Ajout des headers (le Content-Type sera géré par MultipartRequest)
      request.headers['Accept'] = 'application/json';

      // Ajout de l'objet JSON en tant que champ 'apprenant'
      request.fields['apprenant'] = jsonBody;

      // Ajout de l'image si elle existe
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image', // Nom du paramètre attendu par le serveur
          image.path,
        ));
      }

      // Envoi de la requête
      final response = await request.send();

      // Vérification du code de réponse
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Mise à jour réussie: ${response.statusCode}');
        return response.statusCode; // Retourne le code de succès
      } else {
        // Lire la réponse du serveur
        final responseBody = await response.stream.bytesToString();
        print('Échec de la mise à jour: ${response.statusCode}, $responseBody');
        return null; // Retourne null en cas d'échec
      }
    } catch (e) {
      print('Erreur lors de la mise à jour: $e');
      return null; // Retourne null en cas d'erreur d'exécution
    }
  }





}
