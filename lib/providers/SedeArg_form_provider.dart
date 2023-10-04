import 'package:control_actividades/Models/http/SedeArg.dart';
import 'package:flutter/material.dart';
import '../api/endpointApi.dart';

class SedeFormProvider extends ChangeNotifier {
  SedeArg? sede;

  late GlobalKey<FormState> formKey;

  void updateListener() {
    notifyListeners();
  }

  copyUserWith(
    {int? idUniversidad,
	  String? nombre,
    String? tipoSede,
    String? descripcion,
    String? response}) {
    sede = SedeArg(
      idUniversidad: idUniversidad ?? sede!.idUniversidad,
      nombre: nombre ?? sede!.nombre,
      tipoSede: tipoSede ?? sede!.tipoSede,
      descripcion: descripcion ?? sede!.descripcion,
      response: response ?? sede!.response
    );
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
      "idUniversidad": sede!.idUniversidad,
      "nombre": sede!.nombre,
      "tipo_sede": sede!.tipoSede,
      "descripcion": sede!.descripcion,
      "response": sede!.response,
    };

    try {
      final sedes = EndPointApi.httpPut('/sede/${sede!.idUniversidad}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }
}
