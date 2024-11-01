import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sigidakanwmobile/Login.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  final List<String> slogans = [
    "Apprenez nos langues locales gratuitement!",
    "Apprentissage accessible, culture à portée de main!",
    "Explorez notre culture, parlez nos langues!",
  ];

  final List<String> slogansDescript = [
    "Maîtrisez la langue de vos racines, quand vous voulez, où que vous soyez!",
    "Apprenez à votre rythme et embrassez les traditions de votre région avec nos cours de langue!",
    "Renforcez vos liens avec les autres en découvrant les nuances de nos langues locales!",
  ];

  @override
  void initState() {
    super.initState();
    // Timer pour changer de page toutes les 3 secondes
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_activePage < slogans.length - 1) {
        _activePage++;
      } else {
        _activePage = 0;
      }

      _pageController.animateToPage(
        _activePage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: largeur,
          height: hauteur,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Logo et Titre
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'Assets/Images/logo_green.png',
                    ),
                  ],
                ),
              ),
              // Partie verte avec le texte et le slider
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF58CC02),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Slider
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: slogans.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    slogans[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: "Lexend",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    slogansDescript[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: "Lexend",
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                            onPageChanged: (index) {
                              setState(() {
                                _activePage = index;
                              });
                            },
                          ),
                        ),
                        // Slider des petits points (indicateurs)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            slogans.length,
                                (index) {
                              return _buildDot(index == _activePage);
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Bouton "Se connecter"
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login())
                            );
                            // Action pour le bouton
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontFamily: "Lexend",
                              color: Color(0xFF58CC02),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour créer les dots du slider
  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 30 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
