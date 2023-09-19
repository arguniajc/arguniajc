import 'package:control_actividades/Models/http/TypeUser.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/typeUserModal_provider.dart';

class TypeUserModal extends StatefulWidget {
  final TypeUser? tipo;

  const TypeUserModal({Key? key, this.tipo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TypeModalState();
}

class _TypeModalState extends State<TypeUserModal> {
  String descripcion = '';
  int? id;

  @override
  void initState() {
    super.initState();

    id = widget.tipo?.idTypeUser;
    descripcion = widget.tipo?.descripcion ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final typeUserProvider = Provider.of<TypeUserModalProvider>(context, listen: false);
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
              Text(widget.tipo?.descripcion ?? 'Nuevo Tipo de usuario',
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
            initialValue: widget.tipo?.descripcion ?? '',
            onChanged: ((value) => descripcion = value),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre de Tipo de usuario',
                label: 'Descripcion',
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
                if (id == null) {
                  await typeUserProvider.newTypeUser(descripcion);
                } else {
                  await typeUserProvider.updateTypeUser(id!,descripcion);
                  NotificationsService.showSnackbar(
                      'Tipo usuario $descripcion actualizado');
                }

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
