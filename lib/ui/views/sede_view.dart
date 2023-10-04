import 'package:control_actividades/Models/http/SedeArg.dart';
import 'package:control_actividades/providers/provider.dart';
import '../../services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';

class SedeView extends StatefulWidget {
  final SedeArg? sede;

  const SedeView({super.key, this.sede});

  @override
  State<SedeView> createState() => CreateSedeView();
}

class CreateSedeView extends State<SedeView> {
  int idUniversidad = 0;
	String nombre = '';
  String tipoSede = '';
  String descripcion = '';

  @override
  void initState() {
    super.initState();
    idUniversidad = widget.sede?.idUniversidad ?? 0;
    nombre = widget.sede?.nombre ?? '';
    tipoSede = widget.sede?.tipoSede ?? '';
    descripcion = widget.sede?.descripcion ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<SedeProvider>(context, listen: false);
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
                    Icons.apps,
                    size: 50,
                  ),
                  title: Text('Sede',
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
                            label: "Nombre de Sede",
                            child: TextFormField(
                              initialValue: widget.sede?.nombre ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el nombre del sede',
                                  label: 'Nombre del sede',
                                  icon: Icons.wysiwyg),
                              onChanged: ((value) => nombre = value)
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Tipo de sede",
                            child: TextFormField(
                              initialValue: widget.sede?.tipoSede ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el tipo de sede',
                                  label: 'Tipo de sede',
                                  icon: Icons.layers),
                              onChanged: ((value) => tipoSede = value)
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                        initialValue: widget.sede?.descripcion ?? '',
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese la descripcion de sede',
                            label: 'Tipo de sede',
                            icon: Icons.layers),
                        onChanged: ((value) => descripcion = value)
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: ElevatedButton(
                        onPressed: () async {
                                  if (idUniversidad == 0) {
                                    await form.newSede(
                                      nombre,
                                      tipoSede,
                                      descripcion
                                    );
                                  } else {
                                    await form.updateSede(
                                      idUniversidad,
                                      nombre,
                                      tipoSede,
                                      descripcion
                                    );
                                    NotificationsService.showSnackbar(
                                        'Sede $nombre actualizado');
                                  }
                                },
                          style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.indigo),
                                  shadowColor: MaterialStateProperty.all(
                                    Colors.transparent)),    
                          child: const Row(
                             children: [
                                    Icon(
                                      Icons.save_outlined,
                                      size: 20,
                                    ),
                                    Text(' Guardar')
                                  ],
                                )     
                      ),
                    )
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
