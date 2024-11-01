import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigidakanwmobile/AccueillPage.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';
import 'ApprenantNav.dart';
import 'ChoixDesLangues.dart';
import 'Modal/UserProvider.dart';
import 'service/AuthService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'Login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  final CrudServiceWithoutImage _withoutImageService = CrudServiceWithoutImage();
  final AuthService _authService = AuthService(); // Initialiser AuthService

  @override
  void initState() {
    super.initState();
    //_authService.logout();
    // Initialisation de l'animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Durée de l'animation
    );

    // Animation de fondu (opacity)
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Animation de zoom (scale)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward(); // Démarre l'animation

    // Simuler un délai avant de passer à la page d'accueil
    Timer(Duration(seconds: 3), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    final String? token = await _authService.getToken();
    print(token);

    if (token != null) {
      bool isTokenExpired = JwtDecoder.isExpired(token);

      if (!isTokenExpired) {
        // Le token est valide
        print('Token valide : $token');
        final userId = await _authService.getUserIdFromToken(token); // Méthode pour récupérer le rôle
        dynamic? user = await _withoutImageService.findUser(userId);
        print(user["langues"]);

        // Redirection après connexion réussie pour l'apprenant
        if (user != null && user["langues"] != null && user["langues"].isEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Choixdeslangues()),
          );
        }else{
          Provider.of<UserProvider>(context, listen: false).initializeUser(userId); // Remplacez 'user_id' par l'ID réel
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
            const ApprenantNav()),
          );
        }
      } else {
        // Le token est expiré
        print('Token expiré');
        // Rediriger vers la page de connexion
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Accueil()),
        );
      }
    } else {
      // Aucun token trouvé, rediriger vers la page de connexion
      print('Aucun token trouvé');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Libérer les ressources d'animation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF58CC02),
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation, // Appliquer l'animation de fondu
          child: ScaleTransition(
              scale: _scaleAnimation, // Appliquer l'animation de zoom
              child: LayoutBuilder(
                builder: (context, Constraints){
                  return Image.asset(
                    'Assets/Images/logo_white.png',
                    fit: BoxFit.cover,
                  );
                },
              )
          ),
        ),
      ),
    );
  }
}
