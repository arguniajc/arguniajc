import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.gamepad, color: Color(0xff7A6BF5)),
          const SizedBox(width: 10),
          Text(
            'Admin ARG',
            style: GoogleFonts.montserratAlternates(
                fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
          )
        ],
      ),
    );
  }
}
