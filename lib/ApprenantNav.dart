import 'package:flutter/material.dart';
import 'package:sigidakanwmobile/AccueillPage.dart';
import 'Realisation.dart';
import 'profil.dart';
import 'home.dart';

class ApprenantNav extends StatefulWidget {
  const ApprenantNav({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ApprenantNav> {
  int _selectedIndfinal = 0;

  List<Widget> _page = [
    Home(),
    Realisation(),
    Profil(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndfinal = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndfinal],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF58CC02), // Utiliser une couleur solide
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //icon: Icon(FontAwesomeIcons.house),
            icon: Image.asset(
              "Assets/Icons/home.png",
              width: 26,
              height: 26,
              color: _selectedIndfinal == 0 ? Color(0xFF58CC02) : Colors.grey,
            ),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            //icon: Icon(FontAwesomeIcons.house),
            icon: Image.asset(
              "Assets/Icons/trophy.png",
              width: 26,
              height: 26,
              color: _selectedIndfinal == 1 ? Color(0xFF58CC02) : Colors.grey,
            ),
            label: "Réalisation",
          ),
          BottomNavigationBarItem(
            //icon: Icon(FontAwesomeIcons.house),
            icon: Image.asset(
              "Assets/Icons/person.png",
              width: 26,
              height: 26,
              color: _selectedIndfinal == 2 ? Color(0xFF58CC02) : Colors.grey,
            ),
            label: "Profil",
          ),
        ],
        currentIndex: _selectedIndfinal,
        onTap: _onItemTap,
      ),
    );
  }
}
