import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importez provider ici
import 'Modal/UserProvider.dart';
import 'Splash.dart';
import 'AccueillPage.dart';
import 'Login.dart';
// Importez d'autres écrans selon vos besoins

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const SigidaKanw(),
    ),
  );
}

class SigidaKanw extends StatelessWidget {
  const SigidaKanw({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My ticketing system",
      initialRoute: "/",
      routes: {
        "/splash": (context) => Splash(),
        "/": (context) => Splash(),
        "/accueil": (context) => Accueil(),
        "/login": (context) => const Login(),
        // Décommentez et ajoutez d'autres routes si nécessaire
        /*
        "/home": (context) => const Home(),
        "/adminnav": (context) => Adminnav(),
        "/apprenantNav": (context) => ApprenantNav(),
        "/formateurNav": (context) => FormateurNav(),
        "/users": (context) => Users(),
        "/profil": (context) => const Profil(),
        "/chatAll": (context) => const Chatall(),
        "/chatRoom": (context) => const ChatRoom(),
        */
      },
    );
  }
}
