import 'package:control_actividades/Models/http/MediosArg.dart';
import 'package:control_actividades/providers/provider.dart';
import '../../services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';

class MediosView extends StatefulWidget {
  final MediosArg? medio;

  const MediosView({super.key, this.medio});

  @override
  State<MediosView> createState() => CreateMedioView();
}

class CreateMedioView extends State<MediosView> {
  int idMedios = 0;
  String nombre = '';
  String tipoMedio = '';
  String medionotificacion = '';
  String? selectedOption;
  List<String> dataMaker = ['Opción 1', 'Opción 2', 'Opción 3'];

  @override
  void initState() {
    super.initState();
    idMedios = widget.medio?.idMedios ?? 0;
    nombre = widget.medio?.nombre ?? '';
    tipoMedio = widget.medio?.tipoMedio ?? '';
    medionotificacion = widget.medio?.medionotificacion ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<MediosProvider>(context, listen: false);
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
                  title: Text('Medios',
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
                            label: "Nombre de medio",
                            child: TextFormField(
                              initialValue: widget.medio?.nombre ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el nombre del medio',
                                  label: 'Nombre del medio',
                                  icon: Icons.wysiwyg),
                              onChanged: ((value) => nombre = value)
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Tipo de medio",
                            child: TextFormField(
                              initialValue: widget.medio?.tipoMedio ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el tipo de medio',
                                  label: 'Tipo de medio',
                                  icon: Icons.layers),
                              onChanged: ((value) => tipoMedio = value)
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                            label: "Medios de notificación",
                            child: TextFormField(
                              initialValue: widget.medio?.medionotificacion,
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el medio de de notificación',
                                  label: 'Medio de de notificación',
                                  icon: Icons.notifications_active),
                              onChanged: ((value) => medionotificacion = value)
                            )),
                      ),
                      //   const SizedBox(width: 12),
                      //   Expanded(
                      //     child: FooterWiget(
                      //       label: 'esto es un prueba',
                      //       child: DropdownButtonFormField<String>(
                      //             value: selectedOption,
                      //             hint: const Text('Selecciona una opcion'),
                      //             onChanged: (String? newValue) {
                      //                           setState(() {
                      //                             selectedOption = newValue;
                      //                           });
                      //                         },
                      //             items: dataMaker.map((item) {
                      //               return DropdownMenuItem<String>(
                      //                     value: item,
                      //                     child: Text(item),
                      //                   );
                      //                 }).toList(),
                      //             decoration: const InputDecoration(
                      //                   enabledBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(color: Colors.grey),
                      //                 ),
                      //                   focusedBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(color: Colors.grey),
                      //                 ),
                      //                 filled: true,
                      //                 fillColor: Colors.transparent,
                      //             ), 
                      //             style: const TextStyle(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w500,
                      //           ),
            
                      // ),
                      //     ),
                      //   )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: ElevatedButton(
                        onPressed: () async {
                                  if (idMedios == 0) {
                                    await form.neMedios(
                                      nombre,
                                      tipoMedio,
                                      medionotificacion
                                    );
                                  } else {
                                    await form.updateMedios(
                                      idMedios,
                                      nombre,
                                      tipoMedio,
                                      medionotificacion
                                    );
                                    NotificationsService.showSnackbar(
                                        'Medio $nombre actualizado');
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
