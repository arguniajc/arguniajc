import 'package:control_actividades/Models/http/infArg.dart';
import 'package:control_actividades/providers/register_form_provider.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import 'package:control_actividades/ui/views/register_view.dart';
import '../../providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTokenView extends StatefulWidget {
  final String? token;

  const RegisterTokenView({Key? key, this.token}) : super(key: key);

  @override
  EditRoleCardView createState() => EditRoleCardView();
}
class EditRoleCardView extends State<RegisterTokenView> {
  String token = '';
  bool roles = false;
  bool buttonRoles = true;
  String? selectedRole = '';
  InfArg? arg;

  @override
  void initState() {
    super.initState();
    token = widget.token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<TypeRegisterTokenModalProvider>(context);
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
                  autovalidateMode: AutovalidateMode.always,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      const Text('Ingrese el Codigo del arg al que se va registrar'),
                      const SizedBox(height: 20),
                      TextFormField(
                        enabled: buttonRoles,
                          initialValue: widget.token ?? '',
                          onChanged: (value) => token = value,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length != 4) {
                               return 'el codigo es de cuatro numeros';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Codigo',
                              label: '',
                              icon: Icons.extension),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: !roles,
                          child: CustomOutlinedButton(
                          onPressed: () async {
                              bool role = await registerFormProvider.validarToken(token);
                              setState(() {
                                roles = role;
                                buttonRoles = !role;
                              });
                              if (role) {
                                  arg = registerFormProvider.args;
                              }
                            },
                            text: 'Validar codigo',
                          ),
                        ),
                        Visibility(
                          visible: roles,
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: item.length,
                                itemBuilder: (context, int index) {
                                  return RadioListTile(
                                    title: Text(item[index].descripcion),
                                    value: item[index].idTypeUser.toString(),
                                    groupValue: selectedRole,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedRole = value;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.trailing,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomOutlinedButton(
                              onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return RegisterView(idarg: arg!.idarg.toString(),tipoUsuario: selectedRole);
                                    }
                                  ));
                                },
                                text: 'Registrarse',
                              ),
                            ],
                          ),
                        )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
