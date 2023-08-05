import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NavbarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/a/a4/Deportivo-cali-escudo.png'),
      ),
    );
  }
}
