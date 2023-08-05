import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class CustomTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'logo.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Iniciar Sesión',
              style: GoogleFonts.montserratAlternates(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '¿aun no tienes cuenta? Registrate',
              style: GoogleFonts.montserratAlternates(
                  fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
