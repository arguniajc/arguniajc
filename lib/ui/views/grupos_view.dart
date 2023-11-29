import 'package:control_actividades/Models/http/GruposArg.dart';
import 'package:control_actividades/providers/provider.dart';
import '../../services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';
//import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'dart:html' as html;  

class GruposView extends StatefulWidget {
  final GruposArg? grupos;

  const GruposView({super.key, this.grupos});

  @override
  State<GruposView> createState() => CreateGruposView();
}

   Future<void> reloadPageAfterDelay() async {
      await Future.delayed(const Duration(seconds: 1));
      html.window.location.reload();
    }
    

class CreateGruposView extends State<GruposView> {
  int idGrupos = 0;
  String nombreGrupo = '';
  int idArg = 0;
  int idProfesor = 0;
  String profesorNombre = '';
  int idSede = 0;
  String nombreSede = '';
  String titulo = '';
  String respuesta = '';
  String? selectedOptionARG;
  String? selectedOptionIE;
  String? selectedOptionProfesor;
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
    profesorNombre = widget.grupos?.profesorNombre ?? '';
    idSede = widget.grupos?.idSede ?? 0;
    nombreSede = widget.grupos?.titulo ?? '';
    titulo = widget.grupos?.titulo ?? '';
    respuesta = widget.grupos?.respuesta ?? '';

    if (widget.grupos != null) {
      selectedOptionARG = widget.grupos?.idArg.toString() ?? '';
      selectedOptionIE = widget.grupos?.idSede.toString() ?? '';
      selectedOptionProfesor = widget.grupos?.idProfesor.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<GruposProvider>(context, listen: false);
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
    final sede = Provider.of<SedeProvider>(context);
    final dataSede = sede.sedeArgs;
    final profesor = Provider.of<ProfesoresProvider>(context);
    final dataprofesor = profesor.profesores;
    final user = Provider.of<AuthProvider>(context).usuario!;
    
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
                                    icon: Icons.group_add),
                                onChanged: ((value) => nombreGrupo = value))),
                      ),
                      const SizedBox(width: 12, height: 12),
                      Expanded(
                          child: FooterWiget(
                        label: 'Seleccionar un ARG',
                        child: SizedBox(
                          height: 51,
                          child: DropdownButtonFormField<String>(
                            value: selectedOptionARG,
                            hint: const Row(
                              children: [
                                Icon(Icons.book, color: Colors.grey),
                                SizedBox(width: 10),
                                Text('Selecciona una opción'),
                              ],
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOptionARG = newValue;
                                if (selectedOptionARG != null) {
                                  idArg = int.parse(selectedOptionARG!);
                                }
                              });
                            },
                            items: dataArg.where((element) => element.tokenUser == user.token).map((item) {
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
                      ))
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(2)),

                  Row(
                    children: [
                      Expanded(
                          child: FooterWiget(
                              label: "Nombre IE",
                              child: SizedBox(
                                height: 51,
                                child: DropdownButtonFormField<String>(
                                  value: selectedOptionIE,
                                  hint: const Row(
                                    children: [
                                      Icon(Icons.school, color: Colors.grey),
                                      SizedBox(width: 10),
                                      Text('Selecciona una opción'),
                                    ],
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedOptionIE = newValue;
                                      if (selectedOptionIE != null) {
                                        idSede = int.parse(selectedOptionIE!);
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
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))),
                      const SizedBox(width: 12, height: 100),
                    Expanded(
                          child: FooterWiget(
                        label: 'Seleccionar un profesor',
                        child: SizedBox(
                          height: 51,
                          child: DropdownButtonFormField<String>(
                            value: selectedOptionProfesor,
                            hint: const Row(
                              children: [
                                Icon(Icons.book, color: Colors.grey),
                                SizedBox(width: 10),
                                Text('Selecciona un profesor'),
                              ],
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOptionProfesor = newValue;
                                if (selectedOptionProfesor != null) {
                                  idProfesor = int.parse(selectedOptionProfesor!);
                                }
                              });
                            },
                            items: dataprofesor.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.idProfesor.toString(),
                                child: Text(item.nombreApellido),
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
                      ))
                    ],
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
                            await form.newGrupos(nombreGrupo, idArg, idSede,
                                idProfesor,profesorNombre, respuesta);
                          } else {
                            await form.updateGrupos(idGrupos, nombreGrupo,
                                idArg, idProfesor, idSede, respuesta);
                            NotificationsService.showSnackbar(
                                'Grupo $nombreGrupo actualizado');
                              
                               reloadPageAfterDelay();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.save_outlined,
                              size: 20,
                            ),
                            Text(' Guardar')
                          ],
                        )),
                  )),
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
