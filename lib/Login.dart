import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigidakanwmobile/ApprenantNav.dart';
import 'package:sigidakanwmobile/ChoixDesLangues.dart';
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';
import 'package:sigidakanwmobile/SignUpLandingPage.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';
import 'Modal/UserProvider.dart';
import 'service/AuthService.dart';
import 'CustomTextField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isEmailValid = true; // Pour le statut de validation
  bool pass = true;
  bool isLoading = false; // Nouvelle variable pour suivre l'état de chargement
  String email = '';
  String password = '';
  final AuthService _authService = AuthService();
  final CrudServiceWithoutImage _withoutImageService = CrudServiceWithoutImage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _validateEmail(String email) {
    // Expression régulière pour vérifier un e-mail valide
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          "Assets/Images/logo_green.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: largeur * 0.021),
                      Container(
                        width: largeur * 0.95,
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 16.0),
                            CustomTextField(
                              xtextAlign: TextAlign.start,
                              labelText: 'Email',
                              hintText: 'Entrez votre email',
                              controller: emailController,
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              errorText: _isEmailValid ? null : "Adresse e-mail invalide",
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  print(email);
                                  _isEmailValid = _validateEmail(email);
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              xtextAlign: TextAlign.start,
                              labelText: 'Mot de passe',
                              hintText: 'Entrez votre mot de passe',
                              isPassword: pass,
                              controller: passwordController,
                              suffixIcon: IconButton(
                                icon: Icon(pass ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    pass = !pass;
                                  });
                                },
                              ),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true; // Affiche le CircularProgressIndicator
                                  });

                                  // Appel du service d'authentification
                                  String? token = await _authService.login(email, password);

                                  setState(() {
                                    isLoading = false; // Cache le CircularProgressIndicator
                                  });

                                  if (token != null) {
                                    // Redirection après connexion réussie
                                    final userRole = await _authService.getUserRoleFromToken(token); // Méthode pour récupérer le rôle
                                    final userId = await _authService.getUserIdFromToken(token); // Méthode pour récupérer le rôle
                                    print(userRole);
                                    print(userId);
                                    if (userRole == 'APPRENANT') {
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
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              const ApprenantNav()),
                                        );
                                      }
                                    }
                                    if (userRole != 'APPRENANT') {
                                      // Redirection après connexion réussie pour l'apprenant
                                      Flushbar(
                                        message: "Vous ne pouvez pas vous connecter avec ce compte",
                                        duration: Duration(seconds: 3), // Durée d'affichage de Flushbar
                                        backgroundColor: Color(0xFF0F4BD9), // Couleur de fond
                                        icon: const Icon(
                                          Icons.check_circle_outline,
                                          size: 28.0,
                                          color: Colors.white,
                                        ),
                                        leftBarIndicatorColor: Color(0xFF4872D5), // Couleur du bord gauche
                                      ).show(context);
                                    }
                                  } else {
                                    // Affichage d'un message d'erreur si la connexion échoue
                                    /*ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Connexion échouée. Veuillez vérifier vos identifiants.')),
                                    );*/
                                    Flushbar(
                                      message: "Connexion échouée. Veuillez vérifier vos identifiants.",
                                      duration: Duration(seconds: 3), // Durée d'affichage de Flushbar
                                      backgroundColor: Color(0xEFFF023B), // Couleur de fond
                                      icon: const Icon(
                                        Icons.check_circle_outline,
                                        size: 28.0,
                                        color: Colors.white,
                                      ),
                                      leftBarIndicatorColor: Color(0xF0E85F5F), // Couleur du bord gauche
                                    ).show(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Color(0xFFFFFFFF),
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Se connecter",
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Lexend",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            isLoading ? const CircularProgressIndicator(
                              color: Color(0xFF58CC02),
                            ) : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "Vous n'avez pas de compte ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Lexend"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupLandinPage()));
                        },
                        child: const Text(
                          "Inscrivez-vous",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Lexend",
                            color: Color(0xFF58CC02),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
