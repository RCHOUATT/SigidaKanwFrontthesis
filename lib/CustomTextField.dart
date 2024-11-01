import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  dynamic xtextAlign = TextAlign.start;
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final Widget? suffixIcon; // Changez ceci pour accepter un Widget
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? errorText;  // Nouvelle propriété pour afficher l'erreur

  CustomTextField({
    super.key,
    this.labelText = "",
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon, // Utilisez Widget ici
    this.keyboardType,
    this.onChanged,
    this.errorText,  // Initialisation de l'erreur
    this.xtextAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon, // Utilisez directement le suffixIcon
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF58CC02),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorText: errorText,  // Affichage de l'erreur
            ),
            textAlign: xtextAlign,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
