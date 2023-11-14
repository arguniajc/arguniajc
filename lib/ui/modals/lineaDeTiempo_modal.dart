import 'package:control_actividades/providers/lineaDeTiempo_provider.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class LineaDeTiempoModal extends StatefulWidget {
  final int? idActividad;
  final String? titulo;
  final String? fechaRealizacion;
  final String? fechaDeFinalizacion;
  final String? tiempoInicial;
  final String? tiempoFinal;

  const LineaDeTiempoModal({Key? key, 
                            this.idActividad,
                            this.titulo, 
                            this.fechaRealizacion, 
                            this.fechaDeFinalizacion,
                            this.tiempoInicial,
                            this.tiempoFinal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TypeModalState();
}

class _TypeModalState extends State<LineaDeTiempoModal> {
  int idActividad = 0;
  String fecharealizacion = '';
  String fechadefinalizacion = '';
  String timeinicial = '';
  String timeFinalizacion = '';
  TextEditingController dateinput = TextEditingController();
  TextEditingController txtTimeController = TextEditingController();
  TextEditingController txtTimeController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    idActividad = widget.idActividad ?? 0;
    fecharealizacion = widget.fechaRealizacion ?? '';
    fechadefinalizacion = widget.fechaDeFinalizacion ?? '';
    timeinicial = widget.tiempoInicial ?? '';
    timeFinalizacion = widget.tiempoFinal ?? '';

    if (fecharealizacion != '') {
      dateinput.text = '${fecharealizacion.substring(0,10) }  -  ${fechadefinalizacion.substring(0,10)}';
      txtTimeController.text = timeinicial;
      txtTimeController2.text = timeFinalizacion;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<LineaDeTiempoProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 700,
      width: 300,
      decoration: builBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.titulo ?? '',
                  style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ))
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
          child: FooterWiget(
              label: "Fecha de realizacion",
              child: TextFormField(
                controller: dateinput,
                style: const TextStyle(color: Colors.white),
                decoration: CustomInputs.formInputDecorationModal(
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
          Row(
            children: [
              Expanded(
                child: FooterWiget(
                  label: "Duración inicial",
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: txtTimeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    decoration: CustomInputs.formInputDecorationModal(
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
                    style: const TextStyle(color: Colors.white),
                    controller: txtTimeController2,
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    decoration: CustomInputs.formInputDecorationModal(
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
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                await form.updateArg2(
                  idActividad,
                  fecharealizacion,
                  fechadefinalizacion,
                  timeinicial,
                  timeFinalizacion
                );
               Navigator.of(context).pop();
              },
              text: 'Guardar',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration builBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0xff0F2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
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
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
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