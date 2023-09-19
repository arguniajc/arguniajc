import 'package:control_actividades/Models/http/infArg.dart';
import 'package:control_actividades/providers/InfArg_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/notifications_service.dart';
import '../inputs/custom_inputs.dart';

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
  String modalidaddeestudio = '';
  String coceptos = '';
  String proposito = '';
  String sinopsis = '';
  String agujerodeconejo = '';
  String jugabilidad = '';
  String participantes = '';
  int duracionaprox = 0;
  String entidad = '';
  String pais = '';
  String lugardeejecucion = '';
  int idPuppetmaster = 0;
  String response = '';

  @override
  void initState() {
    super.initState();

    idarg = widget.arg?.idarg ?? 0;
    titulo = widget.arg?.titulo ?? '';
    observaciones = widget.arg?.observaciones ?? '';
    areadeconocimiento = widget.arg?.areadeconocimiento ?? '';
    asignatura = widget.arg?.asignatura ?? '';
    modalidaddeestudio = widget.arg?.modalidaddeestudio ?? '';
    coceptos = widget.arg?.coceptos ?? '';
    proposito = widget.arg?.proposito ?? '';
    sinopsis = widget.arg?.sinopsis ?? '';
    agujerodeconejo = widget.arg?.agujerodeconejo ?? '';
    jugabilidad = widget.arg?.jugabilidad ?? '';
    participantes = widget.arg?.participantes ?? '';
    duracionaprox = widget.arg?.duracionaprox ?? 0;
    entidad = widget.arg?.entidad ?? '';
    pais = widget.arg?.pais ?? '';
    lugardeejecucion = widget.arg?.lugardeejecucion ?? '';
    idPuppetmaster = widget.arg?.idPuppetmaster ?? 0;
    response = widget.arg?.response ?? '';
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
                              child: TextFormField(
                                initialValue:
                                    widget.arg?.modalidaddeestudio ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese la modalidad de estudio',
                                    label: 'Modalidad',
                                    icon: Icons.build_circle),
                                onChanged: ((value) =>
                                    modalidaddeestudio = value),
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FooterWiget(
                              label: "Duración aproximada",
                              child: TextFormField(
                                initialValue:
                                    widget.arg?.duracionaprox.toString() ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese la duración aproximada',
                                    label: 'tiempo',
                                    icon: Icons.timelapse),
                                onChanged: ((value) =>
                                    duracionaprox = int.parse(value)),
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
                                initialValue: widget.arg?.agujerodeconejo ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese el agujero de conejo',
                                    label: 'agujero',
                                    icon: Icons.holiday_village),
                                onChanged: ((value) => agujerodeconejo = value),
                              )),
                        ),
                        const SizedBox(width: 12),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: FooterWiget(
                              label: "Pais",
                              child: TextFormField(
                                initialValue: widget.arg?.pais ?? '',
                                style: const TextStyle(color: Colors.black),
                                decoration: CustomInputs.loginInputDecoration(
                                    hint: 'Ingrese el pais',
                                    label: 'pais',
                                    icon: Icons.flag),
                                onChanged: ((value) => pais = value),
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
                                initialValue: '',
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
                                  if (idarg == 0) {
                                    await form.newArg(
                                        titulo,
                                        observaciones,
                                        areadeconocimiento,
                                        asignatura,
                                        modalidaddeestudio,
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
                                        idPuppetmaster);
                                  } else {
                                    await form.updateArg(
                                        idarg,
                                        titulo,
                                        observaciones,
                                        areadeconocimiento,
                                        asignatura,
                                        modalidaddeestudio,
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
                                        idPuppetmaster);
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
