import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';

class InfArgView extends StatelessWidget {
  const InfArgView({super.key});

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
            padding: const EdgeInsets.all(10),
            child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text('Título del ARG',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese el nombre del ARG',
                        label: 'ARG',
                        icon: Icons.sports_esports),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                            label: "Area del conocimiento",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el area del conocimiento',
                                  label: 'Area del conocimiento',
                                  icon: Icons.area_chart),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Modalidad de estudio",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la modalidad de estudio',
                                  label: 'Modalidad',
                                  icon: Icons.build_circle),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Duración aproximada",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la duración aproximada',
                                  label: 'tiempo',
                                  icon: Icons.timelapse),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                            label: "Agujero de conejo",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el agujero de conejo',
                                  label: 'agujero',
                                  icon: Icons.holiday_village),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Asignatura",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la asignatura',
                                  label: 'Asignatura',
                                  icon: Icons.book_outlined),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Conceptos",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese los conceptos',
                                  label: 'Conceptos',
                                  icon: Icons.psychology),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Sinopsis',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese Sinopsis',
                        label: 'Sinopsis',
                        icon: Icons.receipt),
                  ),
                  const SizedBox(height: 20),
                  const Text('Propósito',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese el propósito',
                        label: 'Propósito',
                        icon: Icons.sports_score),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                            label: "Jugadores",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese Jugadores',
                                  label: 'Jugadores',
                                  icon: Icons.groups),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Participantes",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese los Participantes',
                                  label: 'Participantes',
                                  icon: Icons.sports_kabaddi),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Pais",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el pais',
                                  label: 'pais',
                                  icon: Icons.flag),
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
                            label: "Entidad desarrolladora",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la entidad desarrolladora',
                                  label: 'Entidad desarrolladora',
                                  icon: Icons.branding_watermark),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Lugares de ejecución",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese los lugares de ejecución',
                                  label: 'Lugares de ejecución',
                                  icon: Icons.place),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Jugabilidad',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese la Jugabilidad',
                        label: 'Jugabilidad',
                        icon: Icons.games),
                  ),
                  const SizedBox(height: 20),
                  const Text('observaciones',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese sus observaciones',
                        label: 'observaciones',
                        icon: Icons.find_in_page),
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
