import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SplashLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Checking...')
          ],
        ),
      ),
    );
  }
}
