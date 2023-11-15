import 'package:control_actividades/providers/provider.dart';
import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';
import 'package:control_actividades/Models/http/actividadesArg.dart';
import '../../services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ActivitiesArgView extends StatefulWidget {
  final ActividadesArg? actividades;

  const ActivitiesArgView({super.key, this.actividades});

  @override
  State<ActivitiesArgView> createState() => CreateActivitiesArgViewState();
}

class CreateActivitiesArgViewState extends State<ActivitiesArgView>  {
  int idactividades = 0;
  String nombre = '';
  String descripcion = '';
  String fecharealizacion = '';
  String fechadefinalizacion = '';
  int idMedios = 0;
  String timeinicial = '';
  String timeFinalizacion = '';
  int idArg = 0;
  TextEditingController dateinput = TextEditingController();
  TextEditingController txtTimeController = TextEditingController();
  TextEditingController txtTimeController2 = TextEditingController();
  String? selectedOption;
  String? selectedOptionArg;

  @override
  void initState() {
    super.initState();
    idactividades = widget.actividades?.idactividades ?? 0;
    nombre = widget.actividades?.nombre ?? '';
    descripcion = widget.actividades?.descripcion ?? '';
    fecharealizacion = widget.actividades?.fecharealizacion ?? '';
    fechadefinalizacion = widget.actividades?.fechadefinalizacion ?? '';
    idMedios = widget.actividades?.idMedios ?? 0;
    timeinicial = widget.actividades?.timeinicial ?? '';
    timeFinalizacion = widget.actividades?.timeFinalizacion ?? '';
    idArg = widget.actividades?.idArg ?? 0;
    if (idMedios != 0) {
      selectedOption = idMedios.toString();
    }
    if (idArg != 0) {
      selectedOptionArg = idArg.toString();
    }
    if (fecharealizacion != '') {
      dateinput.text = '${fecharealizacion.substring(0,10) }  -  ${fechadefinalizacion.substring(0,10)}';
      txtTimeController.text = timeinicial;
      txtTimeController2.text = timeFinalizacion;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;
    final form = Provider.of<ActividadesArgProvider>(context, listen: false);
    final medio = Provider.of<MediosProvider>(context);
    final dataMedio = medio.mediosArgs;
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
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
                  FooterWiget(
                    label: 'Seleccionar un Arg',
                    child: DropdownButtonFormField<String>(
                          value: selectedOptionArg,
                          hint: const Text('Selecciona una opcion'),
                          onChanged: (String? newValue) {
                                        setState(() {
                                          selectedOptionArg = newValue;
                                          if (selectedOptionArg != null) {
                                            idArg = int.parse(selectedOptionArg!);
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FooterWiget(
                          label: 'Seleccionar un medio',
                          child: DropdownButtonFormField<String>(
                                value: selectedOption,
                                hint: const Text('Selecciona una opcion'),
                                onChanged: (String? newValue) {
                                              setState(() {
                                                selectedOption = newValue;
                                                if (selectedOption != null) {
                                                  idMedios = int.parse(selectedOption!);
                                                }
                                              });
                                            },
                                items: dataMedio.map((item) {
                                  return DropdownMenuItem<String>(
                                        value: item.idMedios.toString(),
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
                        ),
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
                                final DateTimeRange? picked =  await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2024),
                                  initialDateRange: DateTimeRange(
                                    start: DateTime.now(),
                                    end: DateTime.now().add(const Duration(days: 7)),
                                  ),
                                  helpText: 'Select a date range',
                                  cancelText: 'Cancel',
                                  confirmText: 'Select',
                                );

                                if (picked != null) {
                                  DateTime startDate = picked.start;
                                  DateTime endDate = picked.end;

                                  // Do something with the selected date range

                                  fecharealizacion = startDate.toString();
                                  fechadefinalizacion = endDate.toString();
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(startDate);
                                  String formattedDate2 = DateFormat('yyyy-MM-dd').format(endDate);
                                    setState(() {
                                      dateinput.text = '$formattedDate - $formattedDate2'; 
                                    });
                                }
                              }
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FooterWiget(
                            label: "Duración inicial",
                            child: TextFormField(
                              controller: txtTimeController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: false),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: '00:00:00',
                                  label: 'tiempo',
                                  icon: Icons.timelapse),
                              inputFormatters: <TextInputFormatter>[
                                TimeTextInputFormatter() // This input formatter will do the job        
                              ],
                              onChanged: (value) => {
                                timeinicial = value
                              },
                            ),
                          )),
                          const SizedBox(width: 16),
                          Expanded(
                          child: FooterWiget(
                            label: "Duración final",
                            child: TextFormField(
                              controller: txtTimeController2,
                              keyboardType: const TextInputType.numberWithOptions(decimal: false),
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: '00:00:00',
                                  label: 'tiempo',
                                  icon: Icons.timelapse),
                              inputFormatters: <TextInputFormatter>[
                                TimeTextInputFormatter2() // This input formatter will do the job        
                              ],
                              onChanged: (value) => {
                                timeFinalizacion = value
                              },
                            ),
                          ))
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
                                      0,
                                      nombre,
                                      descripcion,
                                      fecharealizacion,
                                      fechadefinalizacion,
                                      idMedios,
                                      timeinicial,
                                      timeFinalizacion,
                                      idArg,
                                      user.token
                                    );
                                  } else {
                                    await form.updateArg(
                                      idactividades,
                                      nombre,
                                      descripcion,
                                      fecharealizacion,
                                      fechadefinalizacion,
                                      idMedios,
                                      timeinicial,
                                      timeFinalizacion,
                                      idArg,
                                      user.token
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

class TimeTextInputFormatter extends TextInputFormatter {
  RegExp? exp;
  TimeTextInputFormatter() {
    exp = RegExp(r'^[0-9:]+$');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (exp!.hasMatch(newValue.text)) {
      TextSelection newSelection = newValue.selection;

      String value = newValue.text;
      String newText;

      String leftChunk = '';
      String rightChunk = '';

      if (value.length >= 8) {
        if (value.substring(0, 7) == '00:00:0') {
          leftChunk = '00:00:';
          rightChunk = value.substring(leftChunk.length + 1, value.length);
        } else if (value.substring(0, 6) == '00:00:') {
          leftChunk = '00:0';
          rightChunk = value.substring(6, 7) + ":" + value.substring(7);
        } else if (value.substring(0, 4) == '00:0') {
          leftChunk = '00:';
          rightChunk = value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        } else if (value.substring(0, 3) == '00:') {
          leftChunk = '0';
          rightChunk = value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7, 8) +
              value.substring(8);
        } else {
          leftChunk = '';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        }
      } else if (value.length == 7) {
        if (value.substring(0, 7) == '00:00:0') {
          leftChunk = '';
          rightChunk = '';
        } else if (value.substring(0, 6) == '00:00:') {
          leftChunk = '00:00:0';
          rightChunk = value.substring(6, 7);
        } else if (value.substring(0, 1) == '0') {
          leftChunk = '00:';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7);
        } else {
          leftChunk = '';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        }
      } else {
        leftChunk = '00:00:0';
        rightChunk = value;
      }

      if (oldValue.text.isNotEmpty && oldValue.text.substring(0, 1) != '0') {
        if (value.length > 7) {
          return oldValue;
        } else {
          leftChunk = '0';
          rightChunk = value.substring(0, 1) +
              ":" +
              value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7);
        }
      }

      newText = leftChunk + rightChunk;

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newText.length, newText.length),
        extentOffset: math.min(newText.length, newText.length),
      );

      return TextEditingValue(
        text: newText,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return oldValue;
  }
}

class TimeTextInputFormatter2 extends TextInputFormatter {
  RegExp? exp;
  TimeTextInputFormatter2() {
    exp = RegExp(r'^[0-9:]+$');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (exp!.hasMatch(newValue.text)) {
      TextSelection newSelection = newValue.selection;

      String value = newValue.text;
      String newText;

      String leftChunk = '';
      String rightChunk = '';

      if (value.length >= 8) {
        if (value.substring(0, 7) == '00:00:0') {
          leftChunk = '00:00:';
          rightChunk = value.substring(leftChunk.length + 1, value.length);
        } else if (value.substring(0, 6) == '00:00:') {
          leftChunk = '00:0';
          rightChunk = value.substring(6, 7) + ":" + value.substring(7);
        } else if (value.substring(0, 4) == '00:0') {
          leftChunk = '00:';
          rightChunk = value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        } else if (value.substring(0, 3) == '00:') {
          leftChunk = '0';
          rightChunk = value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7, 8) +
              value.substring(8);
        } else {
          leftChunk = '';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        }
      } else if (value.length == 7) {
        if (value.substring(0, 7) == '00:00:0') {
          leftChunk = '';
          rightChunk = '';
        } else if (value.substring(0, 6) == '00:00:') {
          leftChunk = '00:00:0';
          rightChunk = value.substring(6, 7);
        } else if (value.substring(0, 1) == '0') {
          leftChunk = '00:';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7);
        } else {
          leftChunk = '';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        }
      } else {
        leftChunk = '00:00:0';
        rightChunk = value;
      }

      if (oldValue.text.isNotEmpty && oldValue.text.substring(0, 1) != '0') {
        if (value.length > 7) {
          return oldValue;
        } else {
          leftChunk = '0';
          rightChunk = value.substring(0, 1) +
              ":" +
              value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7);
        }
      }

      newText = leftChunk + rightChunk;

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newText.length, newText.length),
        extentOffset: math.min(newText.length, newText.length),
      );

      return TextEditingValue(
        text: newText,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return oldValue;
  }
}
