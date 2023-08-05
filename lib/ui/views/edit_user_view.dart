import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/providers/users_provider.dart';
import 'package:control_actividades/services/navigation_service.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:control_actividades/ui/cards/white_card.dart';
import 'package:control_actividades/ui/inputs/custom_inputs.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_form_provider.dart';

class EditUserView extends StatefulWidget {
  final String document;

  const EditUserView({Key? key, required this.document}) : super(key: key);

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.document).then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          user = userDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Usuario', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (user == null)
            WhiteCard(
                child: Container(
                    alignment: Alignment.center,
                    height: 400,
                    child: const CircularProgressIndicator())),
          if (user != null) UserViewBody()
        ],
      ),
    );
  }
}

class UserViewBody extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  UserViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {0: FixedColumnWidth(250)},
        children: [
          TableRow(children: [AvatarContainer(), UserViewForm()])
        ],
      ),
    );
  }
}

class UserViewForm extends StatelessWidget {
  const UserViewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    return WhiteCard(
        title: 'Informacion general',
        child: Form(
          key: userFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                initialValue: user.documento.toString(),
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Documento del usuario',
                    label: 'Documento',
                    icon: Icons.badge_outlined),
                onChanged: (value) => user.documento = int.parse(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un documento';
                  }
                  if (value.length < 5) {
                    return 'El documento debe ser mayor a cinco numeros';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: user.nombre,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Nombre del usuario',
                    label: 'Nombre',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(nombre: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  }
                  if (value.length < 2) {
                    return 'El nombre debe ser de dos letras como minimo';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: user.apellido,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Apellido del usuario',
                    label: 'Apellido',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(apellido: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un apellido';
                  }
                  if (value.length < 2) {
                    return 'El apellido debe ser de dos letras como minimo';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: user.email,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Correo del usuario',
                    label: 'Correo',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(email: value),
                validator: (value) {
                  if (!EmailValidator.validate(value ?? '')) {
                    return 'Email no válido';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: user.password,
                obscureText: true,
                decoration: CustomInputs.loginInputDecoration(
                    hint: '*********',
                    label: 'Contraseña',
                    icon: Icons.lock_outline_rounded),
                onChanged: (value) => user.password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe de ser de 6 caracteres';
                  }
                  return null; // Válido
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: ElevatedButton(
                      onPressed: () async {
                        final saved = await userFormProvider.updateUser();
                        if (saved) {
                          NotificationsService.showSnackbar(
                              'Usuario actualizado');
                          // ignore: use_build_context_synchronously
                          Provider.of<UsersProvider>(context, listen: false)
                              .refreshUser(user);
                        } else {
                          NotificationsService.showSnackbarError(
                              'Error al actualizar el usuario');
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.save_outlined,
                            size: 20,
                          ),
                          Text(' Guardar')
                        ],
                      )))
            ],
          ),
        ));
  }
}

class AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    final image = (user.img!.isEmpty)
        ? const Image(image: AssetImage('no-image.jpg'))
        : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);
    return WhiteCard(
        width: 250,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Perfil', style: CustomLabels.h2),
              const SizedBox(height: 20),
              Container(
                  width: 150,
                  height: 160,
                  child: Stack(
                    children: [
                      ClipOval(
                        child: image,
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 45,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 5)),
                            child: FloatingActionButton(
                              backgroundColor: Colors.indigo,
                              elevation: 0,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                              ),
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png'
                                ], allowMultiple: false, type: FileType.custom);

                                if (result != null) {
                                  PlatformFile file = result.files.first;
                                  NotificationsService.showBusyIndicator(
                                      context);

                                  final userImg = await userFormProvider
                                      .uploadImage('user/upload', file, user);

                                  Provider.of<UsersProvider>(context,
                                          listen: false)
                                      .refreshUser(userImg);

                                  Navigator.of(context).pop();
                                } else {
                                  // User canceled the picker
                                }
                              },
                            ),
                          ))
                    ],
                  )),
              const SizedBox(height: 20),
              Text('${user.nombre} ${user.apellido}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
            ],
          ),
        ));
  }
}
