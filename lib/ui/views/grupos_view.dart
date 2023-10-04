import 'package:control_actividades/Models/http/GruposArg.dart';
import 'package:control_actividades/providers/provider.dart';
import '../../services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';
//import 'package:country_state_city_pro/country_state_city_pro.dart';

class GruposView extends StatefulWidget {
  final GruposArg? grupos;

  const GruposView({super.key, this.grupos});

  @override
  State<GruposView> createState() => CreateGruposView();
}

class CreateGruposView extends State<GruposView> {
  int idGrupos = 0;
  String nombreGrupo = '';
  int idArg = 0;
  int idProfesor = 0;
  int idSede = 0;
  String nombreSede = '';
  String titulo = '';
  String respuesta = '';
  String? selectedOption;
  String? selectedOptionSede;
  String countryValue = "";
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  void initState() {
    super.initState();
    idGrupos = widget.grupos?.idGrupos ?? 0;
    nombreGrupo = widget.grupos?.nombreGrupo ?? '';
    idArg = widget.grupos?.idArg ?? 0;
    idProfesor = widget.grupos?.idProfesor ?? 0;
    idSede = widget.grupos?.idSede ?? 0;
    nombreSede = widget.grupos?.titulo ?? '';
    titulo = widget.grupos?.titulo ?? '';
    respuesta = widget.grupos?.respuesta ?? '';

    if (widget.grupos != null) {
      selectedOption = widget.grupos?.idArg.toString() ?? '';
      selectedOptionSede = widget.grupos?.idSede.toString() ?? '';
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<GruposProvider>(context, listen: false);
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
    final sede = Provider.of<SedeProvider>(context);
    final dataSede = sede.sedeArgs;
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
                  title: Text('Grupos',
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
                            label: "Nombre del grupo",
                            child: TextFormField(
                              initialValue: widget.grupos?.nombreGrupo ?? '',
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Ingrese el nombre del grupo',
                                  label: 'Nombre del grupo',
                                  icon: Icons.wysiwyg),
                              onChanged: ((value) => nombreGrupo = value)
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FooterWiget(
                          label: 'Seleccionar un arg',
                          child: DropdownButtonFormField<String>(
                                value: selectedOption,
                                hint: const Text('Selecciona una opcion'),
                                onChanged: (String? newValue) {
                                              setState(() {
                                                selectedOption = newValue;
                                                if (selectedOption != null) {
                                                  idArg = int.parse(selectedOption!);
                                                }
                                              });
                                            },
                                items: dataArg.map((item) {
                                  return DropdownMenuItem<String>(
                                        value: item.idarg.toString(),
                                        child: Text(item.titulo),
                                      );
                                    }).toList(),
                                decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                      focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                ), 
                                style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
           
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                        value: selectedOptionSede,
                        hint: const Text('Selecciona una opcion'),
                        onChanged: (String? newValue) {
                                      setState(() {
                                        selectedOptionSede = newValue;
                                        if (selectedOptionSede != null) {
                                          idSede = int.parse(selectedOptionSede!);
                                        }
                                      });
                                    },
                        items: dataSede.map((item) {
                          return DropdownMenuItem<String>(
                                value: item.idUniversidad.toString(),
                                child: Text(item.nombre),
                              );
                            }).toList(),
                        decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                        ), 
                        style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                  ),
                  // Center(
                  //  child: CountryStateCityPicker(
                  //     country: country,
                  //     state: state,
                  //     city: city,
                  //     dialogColor: Colors.white,
                  //     textFieldDecoration: const InputDecoration(
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //       suffixIcon: Icon(Icons.expand_more), 
                  //       border:  OutlineInputBorder(borderSide: BorderSide.none))
                  //   ), 
                  // ),
                  const SizedBox(height: 20),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: ElevatedButton(
                        onPressed: () async {
                                    if (idGrupos == 0) {
                                    await form.newGrupos(
                                        nombreGrupo,
                                        idArg,
                                        idSede,
                                        respuesta
                                      );
                                  } else {
                                    await form.updateGrupos(
                                      idGrupos,
                                      nombreGrupo,
                                      idArg,
                                      idProfesor,
                                      idSede,
                                      respuesta
                                    );
                                    NotificationsService.showSnackbar(
                                        'Grupo $nombreGrupo actualizado');
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