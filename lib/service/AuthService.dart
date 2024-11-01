import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = 'http://localhost:8081/sigidaKanw/api/auth/login'; // URL de ton API backend

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        String token = response.body; // Le token JWT renvoyé par le backend
        await _saveToken(token);
        return token;
      } else {
        print('Connection échouée: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la Connection: $e');
      return null;
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  // Fonction pour récupérer le rôle de l'utilisateur à partir du token
  Future<String?> getUserRoleFromToken(String token) async {
    try {
      final payload = _decodeJwt(token); // Fonction qui décode le JWT
      return payload['role']; // Assurez-vous que 'role' est la clé correcte
    } catch (e) {
      print('Erreur lors de l\'extraction du rôle: $e');
      return null; // En cas d'erreur, retourner null
    }
  }
  Future<int> getUserIdFromToken(String token) async {
    try {
      final payload = _decodeJwt(token); // Fonction qui décode le JWT
      return payload['userId']; // Assurez-vous que 'role' est la clé correcte
    } catch (e) {
      print('Erreur lors de l\'extraction de l\'id: $e');
      return 0; // En cas d'erreur, retourner null
    }
  }

  Map<String, dynamic> _decodeJwt(String token) {
    return JwtDecoder.decode(token);
  }
}
