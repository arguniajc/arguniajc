import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';

class NotasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
              child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(2),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.note_alt,
                    size: 50,
                  ),
                  title: Text('Notas',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )),
          Card(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                            label: "Universidad",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el nombre de la Universidad',
                                  label: 'Nombre de la Universidad',
                                  icon: Icons.business),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Grupo",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el código del grupo',
                                  label: 'Código Grupo',
                                  icon: Icons.groups),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ])),
          ))
        ],
      ),
    );
  }
}

class FooterWiget extends StatelessWidget {
  final String label;
  final Widget child;

  const FooterWiget({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        child
      ],
    );
  }
}
