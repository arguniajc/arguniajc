import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';

class InfArgView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
              child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.calculate,
                    size: 50,
                  ),
                  title: Text('ARG',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )),
          Card(
            child: Container(
                padding: EdgeInsets.all(2),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: CustomInputs.formInputDecoration(
                            hint: 'Documento del usuario',
                            label: 'Documento',
                            icon: Icons.badge_outlined),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
