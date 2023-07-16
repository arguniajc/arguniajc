import 'package:control_actividades/ui/cards/white_card.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
            child: Image(
          image: AssetImage('logo.png'),
        )));
  }
}
