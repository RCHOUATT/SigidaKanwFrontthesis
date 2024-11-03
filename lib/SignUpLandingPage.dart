import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sigidakanwmobile/ApprenantNav.dart';
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';
import 'package:sigidakanwmobile/signUp.dart';
import 'Login.dart';
import 'Modal/GenreUser.dart';
import 'service/AuthService.dart'; // Assurez-vous que le chemin d'importation est correct
import 'CustomTextField.dart';

class SignupLandinPage extends StatefulWidget {
  const SignupLandinPage({super.key});

  @override
  _SignupLandinPageState createState() => _SignupLandinPageState();
}

class _SignupLandinPageState extends State<SignupLandinPage> {

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: largeur,
        height: hauteur,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: hauteur * 0.6,
                decoration: const BoxDecoration(
                    color: Color(0xFF45A100),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(400, 150),
                      bottomLeft: Radius.elliptical(800, 400),
                    )
                ),
                child: Center(
                  widthFactor: 0.9,
                  heightFactor: 0.9,
                  child: Image.asset("Assets/Images/login.png"),
                ),
              ),
              const SizedBox(height: 70),
              Container(
                  constraints: BoxConstraints(maxWidth: largeur * 0.7),
                  child: const Center(
                    child: Text(
                      "Créer un profil pour sauvegarder votre progression et continuer à apprendre gratuitement.",
                      textAlign: TextAlign.justify,
                    ),
                  )
              ),
              const SizedBox(height: 70),
              Container(
                width: largeur * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 130,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Color(0xFFFFFFFF),
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>Login()));
                          },
                          child: const Text("Retour", style: TextStyle(color: Color(0xFF000000)),)
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Color(0xFF000000),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>Signup()));
                          },
                          child: const Text("Suivant", style: TextStyle(color: Color(0xFFFFFFFF)),)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );}
}
