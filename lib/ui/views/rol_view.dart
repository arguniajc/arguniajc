import 'package:control_actividades/providers/register_form_provider.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import '../../providers/typeUserModal_provider.dart';
import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleCardView extends StatefulWidget {
  final Usuario? user;
  const RoleCardView({Key? key, this.user}) : super(key: key);

  @override
  EditRoleCardView createState() => EditRoleCardView();
}
class EditRoleCardView extends State<RoleCardView> {
  String? selectedRole = '';
  bool estudiante = false;
  // usuario
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

    id = 0;
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
    final userFormProvider = Provider.of<TypeUserModalProvider>(context);
    final item = userFormProvider.typeUsers;
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                    const ListTile(
                    title: Text('Selecciona un rol'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: item.length,
                      itemBuilder: (context, int index) {
                        return RadioListTile(
                          title: Text(item[index].descripcion),
                          value: item[index].descripcion,
                          groupValue: selectedRole,
                          onChanged: (String? value) {
                            setState(() {
                              selectedRole = value;
                              if (selectedRole == 'Estudiante') {
                                estudiante = true;
                              } else {
                                estudiante = false;
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: estudiante,
                      child: TextFormField(
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Nombre de usuario',
                          label: 'Nombre de Usuario',
                          icon: Icons.co_present),
                      ),
                    ),
                    const SizedBox(height: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                                authProvider.register(
                                    nombre,
                                    apellido,
                                    documento,
                                    email,
                                    password);
                        },
                        text: 'Crear cuenta',
                      ),
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
