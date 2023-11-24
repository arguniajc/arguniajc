import 'package:control_actividades/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class NavbarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;

    return ClipOval(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.network(
          user.img ??
              'https://upload.wikimedia.org/wikipedia/commons/c/c1/Sin_fotograf%C3%ADa.jpg',
          fit: BoxFit
              .cover, // Ajusta la imagen para cubrir completamente el espacio
        ),
      ),
    );
  }
}
