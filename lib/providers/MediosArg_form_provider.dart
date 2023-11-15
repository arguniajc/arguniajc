import 'package:control_actividades/Models/http/MediosArg.dart';
import 'package:flutter/material.dart';
import '../api/endpointApi.dart';

class MediosFormProvider extends ChangeNotifier {
  MediosArg? medios;

  late GlobalKey<FormState> formKey;

  void updateListener() {
    notifyListeners();
  }

  copyUserWith(
    {int? idMedios,
      String? nombre,
      String? tipoMedio,
      String? medionotificacion,
      int? idArg,
      String? tokenUser,
      String? response}) {
    medios = MediosArg(
      idMedios: idMedios ?? medios!.idMedios,
      nombre: nombre ?? medios!.nombre,
      tipoMedio: tipoMedio ?? medios!.tipoMedio,
      medionotificacion: medionotificacion ?? medios!.medionotificacion,
      tokenUser: tokenUser ?? medios!.tokenUser,
      response: response ?? medios!.response
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
      "idMedios": medios!.idMedios,
        "nombre": medios!.nombre,
        "tipoMedio": medios!.tipoMedio,
        "medionotificacion": medios!.medionotificacion,
        "response": medios!.response,
    };

    try {
      final medio = EndPointApi.httpPut('/medios/${medios!.idMedios}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }
}
