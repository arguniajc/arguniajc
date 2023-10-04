import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CustomLogo extends StatelessWidget {
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
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
