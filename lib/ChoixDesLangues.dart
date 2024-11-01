import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigidakanwmobile/ApprenantNav.dart';
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';
import 'package:sigidakanwmobile/home.dart';
import 'package:sigidakanwmobile/service/AuthService.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';
import 'Modal/Langues.dart';
import 'Modal/UserProvider.dart';

class Choixdeslangues extends StatefulWidget {
  const Choixdeslangues({super.key});

  @override
  _Choixdeslangues createState() => _Choixdeslangues();
}

class _Choixdeslangues extends State<Choixdeslangues> {
  List<Langues> _langues = <Langues>[];
  final CrudServiceWithoutImage service = CrudServiceWithoutImage();
  final AuthService _authservice = AuthService();
  Langues? _selectedLangue; // Variable pour stocker la langue sélectionnée
  Utilisateur utilisateur = Utilisateur(); // Initialisation de Utilisateur

  @override
  void initState() {
    super.initState();
    _loadLanguages();
  }

  // Méthode pour charger les langues
  void _loadLanguages() {
    final stream = service.getdata("langue");
    stream.listen((data) {
      setState(() {
        print(data);
        // Transformez chaque élément en Langues
        _langues = data.map<Langues>((item) => Langues.fromJson(item)).toList();
        print(_langues);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFE3EDFD),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                  decoration: BoxDecoration(
                    color: const Color(0xFF58CC02),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Langues",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Lexend",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Quelle langue voulez-vous apprendre ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _langues.map((langue) {
                    final isSelected = langue == _selectedLangue;
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 58,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? const Color(0xFF58CC02) : const Color(0xFFDFDFDF),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedLangue = langue; // Update selected language
                            if (_selectedLangue != null) {
                              if (utilisateur.langues.isEmpty) {
                                utilisateur.langues.add(_selectedLangue);
                              } else {
                                utilisateur.langues[0] = _selectedLangue;
                              }
                              print(utilisateur.toJson());
                            }
                          });
                        },
                        child: Text(
                          langue.nom[0].toUpperCase() + langue.nom.substring(1).toLowerCase(),
                          style: TextStyle(
                            color: isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF333333),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if(_selectedLangue != null){
                    int? reponse = await service.UpdateUser(utilisateur);
                    print(reponse);
                    if (reponse! >= 200 && reponse! <= 205) {
                      String? token = await _authservice.getToken();
                      final userId = await _authservice.getUserIdFromToken(token!);
                      Provider.of<UserProvider>(context, listen: false).initializeUser(userId); // Remplacez 'user_id' par l'ID réel
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ApprenantNav()),
                      );
                    }
                  }
                  // Logique pour terminer la sélection de langue
                },
                child: const Text("Terminer", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
