import 'package:control_actividades/Models/http/estudiantesnotas.dart';
import 'package:control_actividades/providers/estudiantesNotas_provider.dart';
import 'package:control_actividades/providers/typeUsers_provider.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotasModal extends StatefulWidget {
  final EstudianteNotas? nota;

  const NotasModal({Key? key, this.nota}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotasModalState();
}

class NotasModalState extends State<NotasModal> {
  double nota = 0;
  int idEstudiante = 0;
  int idActividad = 0;
  @override
  void initState() {
    super.initState();

    nota = widget.nota!.nota;
    idActividad = widget.nota!.idActividad;
    idEstudiante = widget.nota!.idUsuario;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<EstudiantesNotasProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 1000,
      width: 300,
      decoration: builBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.nota?.nombreUsuario.toString()} ${widget.nota?.apellidoUsuario.toString()}',
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
          TextFormField(
            initialValue: widget.nota?.nota.toString() ?? '',
            onChanged: ((value) => nota = double.parse(value)),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nota del estudiante',
                label: 'Nota',
                icon: Icons.supervised_user_circle_sharp),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                await userProvider.updateNota(nota,idActividad,idEstudiante);
                NotificationsService.showSnackbar(
                    'Nota Actualizada');

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
