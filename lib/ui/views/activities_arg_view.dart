import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';

class activitiesArgView extends StatelessWidget {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.menu_book,
                    size: 50,
                  ),
                  title: Text('Actividades',
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
                            label: "Nombre de actividad",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el nombre de la actividad',
                                  label: 'Nombre de actividad',
                                  icon: Icons.wysiwyg),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Descripcion",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la Descripcion',
                                  label: 'Descripcion',
                                  icon: Icons.description),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                            label: "Medios utilizados",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese los medios utilizados',
                                  label: 'Medios utilizados',
                                  icon: Icons.addchart),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Fecha de realizacion",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la fecha de realizacion',
                                  label: 'Fecha de realizacion',
                                  icon: Icons.event),
                            )),
                      ),
                    ],
                  ),
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
