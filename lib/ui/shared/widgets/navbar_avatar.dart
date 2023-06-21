import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/a/a4/Deportivo-cali-escudo.png'),
        width: 30,
        height: 30,
      ),
    );
  }
}
