import 'package:control_actividades/providers/register_form_provider.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import '../../providers/typeUserModal_provider.dart';
import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTokenView extends StatefulWidget {
  const RegisterTokenView({Key? key}) : super(key: key);

  @override
  EditRoleCardView createState() => EditRoleCardView();
}
class EditRoleCardView extends State<RegisterTokenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final userFormProvider = Provider.of<TypeUserModalProvider>(context);
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
                      const Text('Ingrese el token del arg al que se va registrar'),
                      TextFormField(
                          onChanged: (value) => registerFormProvider.token = int.parse(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Token',
                              label: 'Token del arg',
                              icon: Icons.extension),
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
