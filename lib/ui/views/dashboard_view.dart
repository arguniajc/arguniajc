import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage('logo.png'),
            height: 600,
            width: 600,
          ),
          Positioned(
            bottom: 300,
            child: Text(
              'Transformando el aprendizaje con experiencias educativas inmersivas.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Puedes ajustar el color del texto
              ),
            ), // Ajusta la posición del texto desde la parte superior
          ),
        ],
      ),
    );
  }
}
