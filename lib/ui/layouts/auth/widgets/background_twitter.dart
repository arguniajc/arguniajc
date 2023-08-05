import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class BackgroundTwitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: const AssetImage('logo.png'),
              width: 200,
              color: Colors.blue[200],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('imgprincipal.png'), fit: BoxFit.cover));
  }
}
