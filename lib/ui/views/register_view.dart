import 'package:control_actividades/providers/register_form_provider.dart';
import 'package:control_actividades/router/router.dart';
import 'package:control_actividades/ui/buttons/custom_outlined_button.dart';
import 'package:control_actividades/ui/buttons/link_text.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
//import 'package:control_actividades/ui/views/rol_view.dart';
import 'package:control_actividades/providers/sidemenu_provider.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  final String? idgrupo;
  final String? tipoUsuario;

  const RegisterView({Key? key, this.idgrupo, this.tipoUsuario}) : super(key: key);

  @override
  CreateRegisterView createState() => CreateRegisterView();
}

class CreateRegisterView extends State<RegisterView> {
  String idarg = '';
  String tipoUsuario = '';
  bool visibleContrasena = true;
  
  @override
  void initState() {
    super.initState();
    idarg = widget.idgrupo ?? '';
    tipoUsuario = widget.tipoUsuario ?? '';
    if (idarg != '' && tipoUsuario == '1') {
        visibleContrasena = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
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
                      // nombre
                      TextFormField(
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El nombre es obligatario';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su nombre',
                            label: 'Nombre',
                            icon: Icons.supervised_user_circle_sharp),
                      ),

                      const SizedBox(height: 20),

                      // Apellido
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.apellido = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El apellido es obligatario';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese sus apellidos',
                            label: 'Apellidos',
                            icon: Icons.supervised_user_circle_sharp),
                      ),

                      const SizedBox(height: 20),

                      // documento
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) =>
                            registerFormProvider.documento = int.parse(value),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Ingrese el numero';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su documento',
                            label: 'Documento',
                            icon: Icons.perm_identity),
                      ),

                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? '')) {
                            return 'Email no válido';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su correo',
                            label: 'Email',
                            icon: Icons.email_outlined),
                      ),

                      const SizedBox(height: 20),
                      Visibility(
                        visible: visibleContrasena,
                        child: TextFormField(
                          onChanged: (value) =>
                              registerFormProvider.password = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su contraseña';
                            }
                            if (value.length < 6) {
                              return 'La contraseña debe de ser de 6 caracteres';
                            }

                            return null; // Válido
                          },
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '*********',
                              label: 'Contraseña',
                              icon: Icons.lock_outline_rounded),
                        ),
                      ),
                      // Password

                      const SizedBox(height: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          final validForm = registerFormProvider.validateForm();
                          if (!validForm) return;

                          if (sideMenuProvider.currentPage == Flurorouter.registerRoute || sideMenuProvider.currentPage == '/auth/login') {
                            final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                                authProvider.register(
                                    registerFormProvider.name!,
                                    registerFormProvider.apellido!,
                                    registerFormProvider.documento!,
                                    registerFormProvider.email!,
                                    registerFormProvider.password!);
                          } else {
                            final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                                authProvider.registerToken(
                                    registerFormProvider.name!,
                                    registerFormProvider.apellido!,
                                    registerFormProvider.documento!,
                                    registerFormProvider.email!,
                                    registerFormProvider.password!,
                                    idarg,
                                    tipoUsuario);
                          }
                        },
                        text: 'Crear Cuenta',
                      ),

                      const SizedBox(height: 20),
                      LinkText(
                        text: 'Ir al login',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Flurorouter.loginRoute);
                        },
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