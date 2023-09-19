import 'package:control_actividades/Models/http/actividadesArg.dart';
import 'package:flutter/material.dart';
import '../api/endpointApi.dart';

class ArgFormProvider extends ChangeNotifier {
  ActividadesArg? actividades;

  late GlobalKey<FormState> formKey;

  void updateListener() {
    notifyListeners();
  }

  copyUserWith(
      {int? idactividades,
      String? medios,
      DateTime? fecharealizacion,
      String? nombre,
      String? descripcion,
      int? idMedios,
      String? response}) {
    actividades = ActividadesArg(
          idactividades: idactividades ?? actividades!.idactividades,
          medios: medios ?? actividades!.medios,
          fecharealizacion: fecharealizacion ?? actividades!.fecharealizacion,
          nombre: nombre ?? actividades!.nombre,
          descripcion: descripcion ?? actividades!.descripcion,
          idMedios: idMedios ?? actividades!.idMedios,
          response: response ?? actividades!.response
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
      "idactividades": actividades!.idactividades,
      "medios": actividades!.medios,
      "fecharealizacion": actividades!.fecharealizacion,
      "nombre": actividades!.nombre,
      "descripcion": actividades!.descripcion,
      "idMedios": actividades!.idMedios
    };

    try {
      final activities = EndPointApi.httpPut('/activities/${actividades!.idactividades}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }
}
