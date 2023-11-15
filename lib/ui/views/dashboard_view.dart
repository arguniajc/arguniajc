import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import '../../providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AuthProvider>(context).usuario!;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Center(
            child: Image(
          image: AssetImage('logo.png'),
        )));
  }
}
