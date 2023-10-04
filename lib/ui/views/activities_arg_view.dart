import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';
import 'package:control_actividades/providers/actividadesArg_provider.dart';
import 'package:control_actividades/Models/http/actividadesArg.dart';
import '../../services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ActivitiesArgView extends StatefulWidget {
  final ActividadesArg? actividades;

  const ActivitiesArgView({super.key, this.actividades});

  @override
  State<ActivitiesArgView> createState() => CreateActivitiesArgViewState();
}

class CreateActivitiesArgViewState extends State<ActivitiesArgView>  {
  int idactividades = 0;
  String medios = '';
  DateTime fecharealizacion = DateTime.now();
  String nombre = '';
  String descripcion = '';
  int idMedios = 0;
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    super.initState();
    idactividades = widget.actividades?.idactividades ?? 0;
    medios = widget.actividades?.medios ?? '';
    fecharealizacion = widget.actividades?.fecharealizacion ?? DateTime.now();
    nombre = widget.actividades?.nombre ?? '';
    descripcion = widget.actividades?.descripcion ?? '';
    idMedios = widget.actividades?.idMedios ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<ActividadesArgProvider>(context, listen: false);
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
                              initialValue: widget.actividades?.nombre ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el nombre de la actividad',
                                  label: 'Nombre de actividad',
                                  icon: Icons.wysiwyg),
                              onChanged: ((value) => nombre = value),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Descripcion",
                            child: TextFormField(
                              initialValue: widget.actividades?.descripcion ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la Descripcion',
                                  label: 'Descripcion',
                                  icon: Icons.description),
                              onChanged: ((value) => descripcion = value),
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
                              initialValue: widget.actividades?.medios ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese los medios utilizados',
                                  label: 'Medios utilizados',
                                  icon: Icons.addchart),
                              onChanged: ((value) => medios = value),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                            label: "Fecha de realizacion",
                            child: TextFormField(
                              controller: dateinput,
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese la fecha de realizacion',
                                  label: 'Fecha de realizacion',
                                  icon: Icons.calendar_today),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: widget.actividades?.fecharealizacion ?? DateTime.now(),
                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101)
                                );
                                
                                if(pickedDate != null ) {
                                    fecharealizacion = pickedDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    
                                    setState(() {
                                      dateinput.text = formattedDate; //set output date to TextField value. 
                                    });
                                }
                              },
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: ElevatedButton(
                        onPressed: () async {
                                  if (idactividades == 0) {
                                    await form.newArg(
                                      idactividades,
                                      medios,
                                      fecharealizacion,
                                      nombre,
                                      descripcion,
                                      idMedios
                                    );
                                  } else {
                                    await form.updateArg(
                                      idactividades,
                                      medios,
                                      fecharealizacion,
                                      nombre,
                                      descripcion,
                                      idMedios
                                    );
                                    NotificationsService.showSnackbar(
                                        'Actividades $nombre actualizado');
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
