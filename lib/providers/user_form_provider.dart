import 'dart:typed_data';

import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:flutter/material.dart';

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
        token: token ?? user!.token);
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
      "img": ""
    };

    try {
      final usuario = EndPointApi.httpPut('/user/${user!.idusuario}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }

  Future<Usuario> uploadImage(String path, Uint8List bytes) async {
    try {
      final resp = await EndPointApi.uploadFile(path, bytes);
      user = Usuario.fromMap(resp);
      notifyListeners();
      return user!;
    } catch (e) {
      throw 'Error en user from provider';
    }
  }
}
