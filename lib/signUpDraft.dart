/*
import 'package:flutter/material.dart';
import 'package:sigidakanwmobile/ApprenantNav.dart';
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';
import 'Login.dart';
import 'Modal/GenreUser.dart';
import 'service/AuthService.dart'; // Assurez-vous que le chemin d'importation est correct
import 'CustomTextField.dart';

class SignupDraft extends StatefulWidget {
  const SignupDraft({super.key});

  @override
  _SignupDraftState createState() => _SignupDraftState();
}

class _SignupDraftState extends State<SignupDraft> {
  Utilisateur newuser = new Utilisateur(nom: '', email: '', pays: '', dateBirthday: DateTime.now() , adresse: '', password: '', genreUser: GenreUser(id: 0, genre : ""));
  bool pass = true; // Correction: pas besoin de 'late' ici
  bool pass1 = true; // Correction: pas besoin de 'late' ici
  String email = '';
  String nom = '';
  String birthDay = '';
  String nationnalite = '';
  String firstpassword = '';
  String password = '';
  String secondpassword = '';
  final CrudServiceWithoutImage newService = CrudServiceWithoutImage();
  final TextEditingController nationnaliteController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmerpasswordController = TextEditingController();

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
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          "Assets/Images/logo_green.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: largeur * 0.95,
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              labelText: 'Nom',
                              hintText: 'Entrez votre nom',
                              controller: nomController,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                setState(() {
                                  nom = value;
                                  newuser.nom = nom;
                                  print("this.newuser.nom : " + newuser.nom);
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              labelText: 'Nationnalité',
                              hintText: 'Entrez votre pays',
                              controller: nationnaliteController,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  nationnalite = value;
                                  newuser.pays = nationnalite;
                                  print("newuser.nationnalite : " + newuser.pays);
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              labelText: 'Date de naissance',
                              hintText: 'Entrez votre Date de naissance',
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              onChanged: (value) {
                                setState(() {
                                  birthDay = value;
                                  newuser.dateNaissance = birthDay;
                                  print("newuser.dateNaissance : " + newuser.dateNaissance);
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              labelText: 'Email',
                              hintText: 'Entrez votre email',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  newuser.email = email;
                                  print("newuser.email : " + newuser.email);
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              labelText: 'Mot de passe',
                              hintText: 'Entrez votre mot de passe',
                              isPassword: pass1,
                              controller: passwordController,
                              suffixIcon: IconButton(
                                icon: Icon(pass1 ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    pass1 = !pass1; // Change l'état du mot de passe
                                  });
                                },
                              ),
                              onChanged: (value) {
                                setState(() {
                                  firstpassword = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              labelText: 'Confirmer Mot de passe',
                              hintText: 'Entrez votre mot de passe une nouvelle fois',
                              isPassword: pass,
                              controller: confirmerpasswordController,
                              suffixIcon: IconButton(
                                icon: Icon(pass ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    pass = !pass; // Change l'état du mot de passe
                                  });
                                },
                              ),
                              onChanged: (value) {
                                setState(() {
                                  secondpassword = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(firstpassword == secondpassword){
                                    // Appel du service d'authentification
                                    print(this.newuser.toString());
                                    String? token = await newService.post("utilisateur", newuser.toString());

                                    if (token == 200 || token == 201 || token == 202) {
                                      // Redirection après connexion réussie
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Login()),
                                      );
                                    } else {
                                      // Affichage d'un message d'erreur si la connexion échoue
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Echec lors de la creation de votre compte. Veuillez reprendre s\'il vous plais .')),
                                      );
                                    }
                                  }
                                  if(firstpassword != secondpassword){
                                    // Affichage d'un message d'erreur si la connexion échoue
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Vos mots de passe de confirmation n\'est pas correcte')),
                                    );
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
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "Vous n'avez pas de compte ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Lexend"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: const Text(
                          "Inscriver-vous",
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
*/
