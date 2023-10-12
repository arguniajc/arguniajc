import 'dart:math' as math;
import 'package:control_actividades/Models/http/infArg.dart';
import 'package:control_actividades/providers/InfArg_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/notifications_service.dart';
import '../inputs/custom_inputs.dart';
import 'package:flutter/services.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';

class InfArgView extends StatefulWidget {
  final InfArg? arg;

  const InfArgView({super.key, this.arg});

  @override
  State<InfArgView> createState() => CreateArgViewState();
}

class CreateArgViewState extends State<InfArgView> {
  int idarg = 0;
  String titulo = '';
  String observaciones = '';
  String areadeconocimiento = '';
  String asignatura = '';
  String? modalidaddeestudio;
  String coceptos = '';
  String proposito = '';
  String sinopsis = '';
  String agujerodeconejo = '';
  String jugabilidad = '';
  String participantes = '';
  String duracionaprox = '';
  String entidad = '';
  String pais = '';
  String lugardeejecucion = '';
  int idPuppetmaster = 0;
  String estado = '';
  String ciduad = '';
  String response = '';
  List<String> modalidadEstudios = ['Presencial', 'A distancia', 'Semipresencial','Virtual','Modalidad mixta'];
  TextEditingController txtTimeController = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  void initState() {
    super.initState();

    idarg = widget.arg?.idarg ?? 0;
    titulo = widget.arg?.titulo ?? '';
    observaciones = widget.arg?.observaciones ?? '';
    areadeconocimiento = widget.arg?.areadeconocimiento ?? '';
    asignatura = widget.arg?.asignatura ?? '';
    modalidaddeestudio = widget.arg?.modalidaddeestudio ?? 'Presencial';
    coceptos = widget.arg?.coceptos ?? '';
    proposito = widget.arg?.proposito ?? '';
    sinopsis = widget.arg?.sinopsis ?? '';
    agujerodeconejo = widget.arg?.agujerodeconejo ?? '';
    jugabilidad = widget.arg?.jugabilidad ?? '';
    participantes = widget.arg?.participantes ?? '';
    duracionaprox = widget.arg?.duracionaprox ?? '00:00:00';
    entidad = widget.arg?.entidad ?? '';
    pais = widget.arg?.pais ?? '';
    lugardeejecucion = widget.arg?.lugardeejecucion ?? '';
    idPuppetmaster = widget.arg?.idPuppetmaster ?? 0;
    estado = widget.arg?.estado ?? '';
    ciduad = widget.arg?.ciudad ?? '';
    response = widget.arg?.response ?? '';
    txtTimeController.text = duracionaprox;
    country.text = pais;
    state.text = estado;
    city.text = ciduad;
  }

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<InfArgProvider>(context, listen: false);
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
                      Icons.book,
                      size: 50,
                    ),
                  )
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: widget.arg?.titulo ?? '',
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese el nombre del ARG',
                          label: 'ARG',
                          icon: Icons.sports_esports),
                      onChanged: ((value) => titulo = value),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FooterWiget(
                              label: "Area del conocimiento",
                              child: TextFormField(
                                initialValue:
                                    widget.arg?.areadeconocimiento ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese el area del conocimiento',
                                    label: 'Area del conocimiento',
                                    icon: Icons.area_chart),
                                onChanged: ((value) =>
                                    areadeconocimiento = value),
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                        child: FooterWiget(
                          label: "Modalidad de estudio",
                          child: DropdownButtonFormField<String>(
                                value: modalidaddeestudio,
                                hint: const Text('Modalidad de estudio'),
                                onChanged: (String? newValue) {
                                              setState(() {
                                                modalidaddeestudio = newValue;
                                              });
                                            },
                                items: modalidadEstudios.map((item) {
                                  return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
                                    ),
                                      focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
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
                              label: "Duración aproximada",
                              child: TextFormField(
                                maxLength: 2,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                initialValue:
                                    widget.arg?.duracionaprox.toString() ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese la duración aproximada',
                                    label: 'Dias de duracion',
                                    icon: Icons.timelapse),
                                onChanged: ((value) =>
                                    duracionaprox = value),
                              )),
                        ),
                        // const SizedBox(width: 12),
                        // Expanded(
                        //   child: FooterWiget(
                        //     label: "Duración aproximada",
                        //     child: TextFormField(
                        //       controller: txtTimeController,
                        //       keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        //       decoration: CustomInputs.loginInputDecoration(
                        //           hint: '00:00:00',
                        //           label: 'tiempo',
                        //           icon: Icons.timelapse),
                        //       inputFormatters: <TextInputFormatter>[
                        //         TimeTextInputFormatter() // This input formatter will do the job        
                        //       ],
                        //       onChanged: (value) => {
                        //         duracionaprox = value
                        //       },
                        //     ),
                        //   ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    FooterWiget(
                      label: "Agujero de conejo",
                      child: TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: widget.arg?.agujerodeconejo ?? '',
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese el agujero de conejo',
                          label: 'agujero',
                          icon: Icons.holiday_village),
                      onChanged: ((value) => agujerodeconejo = value),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FooterWiget(
                              label: "Asignatura",
                              child: TextFormField(
                                initialValue: widget.arg?.asignatura ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese la asignatura',
                                    label: 'Asignatura',
                                    icon: Icons.book_outlined),
                                onChanged: ((value) => asignatura = value),
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FooterWiget(
                              label: "Conceptos",
                              child: TextFormField(
                                initialValue: widget.arg?.coceptos ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese los conceptos',
                                    label: 'Conceptos',
                                    icon: Icons.psychology),
                                onChanged: ((value) => coceptos = value),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Sinopsis',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: widget.arg?.sinopsis ?? '',
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese Sinopsis',
                          label: 'Sinopsis',
                          icon: Icons.receipt),
                      onChanged: ((value) => sinopsis = value),
                    ),
                    const SizedBox(height: 20),
                    const Text('Propósito',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: widget.arg?.proposito ?? '',
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese el propósito',
                          label: 'Propósito',
                          icon: Icons.sports_score),
                      onChanged: ((value) => proposito = value),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FooterWiget(
                              label: "Jugabilidad",
                              child: TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                initialValue: widget.arg?.jugabilidad ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese Jugabilidad',
                                    label: 'Jugabilidad',
                                    icon: Icons.groups),
                                onChanged: ((value) => jugabilidad = value),
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FooterWiget(
                              label: "Participantes",
                              child: TextFormField(
                                initialValue: widget.arg?.participantes ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese los Participantes',
                                    label: 'Participantes',
                                    icon: Icons.sports_kabaddi),
                                onChanged: ((value) => participantes = value),
                              )),
                        ),
                        // const SizedBox(width: 12),
                        // Expanded(
                        //   child: FooterWiget(
                        //       label: "Pais",
                        //       child: TextFormField(
                        //         initialValue: widget.arg?.pais ?? '',
                        //         style: const TextStyle(color: Colors.black),
                        //         decoration: CustomInputs.loginInputDecoration(
                        //             hint: 'Ingrese el pais',
                        //             label: 'pais',
                        //             icon: Icons.flag),
                        //         onChanged: ((value) => pais = value),
                        //       )),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                     child: FooterWiget(
                      label: 'Ubicacion', 
                      child: CountryStateCityPicker(
                        country: country,
                        state: state,
                        city: city,
                        dialogColor: Colors.white,
                        textFieldDecoration: InputDecoration(
                          border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: const Icon(Icons.expand_more),)
                      )) 
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FooterWiget(
                              label: "Entidad desarrolladora",
                              child: TextFormField(
                                initialValue: widget.arg?.entidad ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese la entidad desarrolladora',
                                    label: 'Entidad desarrolladora',
                                    icon: Icons.branding_watermark),
                                onChanged: ((value) => entidad = value),
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FooterWiget(
                              label: "Lugares de ejecución",
                              child: TextFormField(
                                initialValue:
                                    widget.arg?.lugardeejecucion ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese los lugares de ejecución',
                                    label: 'Lugares de ejecución',
                                    icon: Icons.place),
                                onChanged: ((value) =>
                                    lugardeejecucion = value),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Jugabilidad',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: widget.arg?.jugabilidad ?? '',
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese la Jugabilidad',
                          label: 'Jugabilidad',
                          icon: Icons.games),
                      onChanged: ((value) => jugabilidad = value),
                    ),
                    const SizedBox(height: 20),
                    const Text('observaciones',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: widget.arg?.observaciones ?? '',
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese sus observaciones',
                          label: 'observaciones',
                          icon: Icons.find_in_page),
                      onChanged: ((value) => observaciones = value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: ElevatedButton(
                                onPressed: () async {
                                  pais = country.text;
                                  estado = state.text;
                                  ciduad = city.text;
                                  if (idarg == 0) {
                                    await form.newArg(
                                        titulo,
                                        observaciones,
                                        areadeconocimiento,
                                        asignatura,
                                        modalidaddeestudio!,
                                        coceptos,
                                        proposito,
                                        sinopsis,
                                        agujerodeconejo,
                                        jugabilidad,
                                        participantes,
                                        duracionaprox,
                                        entidad,
                                        pais,
                                        lugardeejecucion,
                                        idPuppetmaster,
                                        estado,
                                        ciduad);
                                  } else {
                                    await form.updateArg(
                                        idarg,
                                        titulo,
                                        observaciones,
                                        areadeconocimiento,
                                        asignatura,
                                        modalidaddeestudio!,
                                        coceptos,
                                        proposito,
                                        sinopsis,
                                        agujerodeconejo,
                                        jugabilidad,
                                        participantes,
                                        duracionaprox,
                                        entidad,
                                        pais,
                                        lugardeejecucion,
                                        idPuppetmaster,
                                        estado,
                                        ciduad);
                                    NotificationsService.showSnackbar(
                                        'Arg $titulo actualizado');
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
                                ))))
                  ])),
            ))
          ],
        ));
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
