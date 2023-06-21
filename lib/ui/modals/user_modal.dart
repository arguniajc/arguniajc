import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users_provider.dart';

class UserModal extends StatefulWidget {
  final Usuario? user;

  const UserModal({Key? key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  String nombre = '';
  String apellido = '';
  int documento = 0;
  String email = '';
  String password = '';
  String response = '';
  String token = '';
  String img = '';
  int? id;

  @override
  void initState() {
    super.initState();

    id = widget.user?.idusuario;
    nombre = widget.user?.nombre ?? '';
    apellido = widget.user?.apellido ?? '';
    documento = widget.user?.documento ?? 0;
    email = widget.user?.email ?? '';
    password = widget.user?.password ?? '';
    response = widget.user?.response ?? '';
    token = widget.user?.token ?? '';
    img = widget.user?.img ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(20),
      height: 2000,
      width: 300,
      decoration: builBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.user?.nombre ?? 'Nuevo usuario',
                  style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
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
            initialValue: widget.user?.nombre ?? '',
            onChanged: ((value) => nombre = value),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre de usuario',
                label: 'Nombre de Usuario',
                icon: Icons.co_present),
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.user?.apellido ?? '',
            onChanged: ((value) => apellido = value),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre de usuario',
                label: 'Apellido de Usuario',
                icon: Icons.co_present),
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.user?.documento.toString() ?? '',
            onChanged: ((value) => documento = int.parse(value)),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Documento', label: 'Documneto', icon: Icons.co_present),
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.user?.email ?? '',
            onChanged: ((value) => email = value),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Email', label: 'Email', icon: Icons.co_present),
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.user?.password ?? '',
            onChanged: ((value) => password = value),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Password', label: 'Password', icon: Icons.co_present),
            style: TextStyle(color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                if (id == null) {
                  await userProvider.newUser(
                      nombre, apellido, documento, email, password);
                } else {
                  await userProvider.updateUser(id!, nombre, apellido,
                      documento, email, password, response, token, img);
                  NotificationsService.showSnackbar(
                      'Usuario $nombre $apellido actualizado');
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

  BoxDecoration builBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0xff0F2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
