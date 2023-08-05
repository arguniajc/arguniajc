import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoPageFoundView extends StatelessWidget {
  const NoPageFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: Text(
          '404 - Página no encontrada',
          style: GoogleFonts.montserratAlternates(
              fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
