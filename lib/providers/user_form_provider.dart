import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary/cloudinary.dart';
import '../api/endpointApi.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;

  late GlobalKey<FormState> formKey;

  void updateListener() {
    notifyListeners();
  }

  copyUserWith({
    int? idusuario,
    int? documento,
    String? nombre,
    String? apellido,
    String? email,
    String? password,
    int? idTipoUsuario,
    String? response,
    String? token,
    String? img,
  }) {
    user = Usuario(
        idusuario: idusuario ?? user!.idusuario,
        documento: documento ?? user!.documento,
        nombre: nombre ?? user!.nombre,
        apellido: apellido ?? user!.apellido,
        email: email ?? user!.email,
        password: password ?? user!.password,
        idTipoUsuario: idTipoUsuario ?? user!.idTipoUsuario,
        response: response ?? user!.response,
        token: token ?? user!.token,
        img: img ?? user!.img);
    notifyListeners();
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {
    if (!validForm()) {
      return false;
    }

    final data = {
      "documento": user!.documento,
      "nombre": user!.nombre,
      "apellido": user!.apellido,
      "email": user!.email,
      "password": user!.password,
      "id_tipo_usuario": 1,
      "response": user!.response,
      "token": user!.token,
      "img": user!.img
    };

    try {
      final usuario = EndPointApi.httpPut('/user/${user!.idusuario}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }

  Future<Usuario> uploadImage(
      String path, PlatformFile file, Usuario userImg) async {
    final cloudinary = Cloudinary.signedConfig(
      apiKey: '853725776848698',
      apiSecret: '9GMXpRluzCHU3Zhlgw5RgEZV85M',
      cloudName: 'dhhu0nqcm',
    );

    final response = await cloudinary.upload(
        file: file.path,
        fileBytes: file.bytes,
        resourceType: CloudinaryResourceType.image,
        fileName: 'imgUser${userImg.idusuario}',
        progressCallback: (count, total) {});

    if (response.isSuccessful) {
      userImg.img = response.secureUrl;
    }

    final data = {
      "documento": userImg.documento,
      "nombre": userImg.nombre,
      "apellido": userImg.apellido,
      "email": userImg.email,
      "password": userImg.password,
      "id_tipo_usuario": 1,
      "response": userImg.response,
      "token": userImg.token,
      "img": userImg.img
    };

    try {
      EndPointApi.httpPut('/user/${userImg.idusuario}', data);
      user = userImg;
      notifyListeners();

      return user!;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }
}
