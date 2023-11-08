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
      String? nombre,
      String? descripcion,
      String? fecharealizacion,
      String? fechadefinalizacion,
      int? idMedios,
      String? timeinicial,
      String? timeFinalizacion,
      int? idArg,
      String? response}) {
    actividades = ActividadesArg(
          idactividades: idactividades ?? actividades!.idactividades,
          nombre: nombre ?? actividades!.nombre,
          descripcion: descripcion ?? actividades!.descripcion,
          fecharealizacion: fecharealizacion ?? actividades!.fecharealizacion,
          fechadefinalizacion: fechadefinalizacion ?? actividades!.fechadefinalizacion,
          idMedios: idMedios ?? actividades!.idMedios,
          timeinicial: timeinicial ?? actividades!.timeinicial,
          timeFinalizacion: timeFinalizacion ?? actividades!.timeFinalizacion,
          idArg: idArg ?? actividades!.idArg,
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
      "nombre": actividades!.nombre,
      "descripcion": actividades!.descripcion,
      "fecharealizacion": actividades!.fecharealizacion,
      "idMedios": actividades!.idMedios,
      "timeinicial": actividades!.timeinicial,
      "timeFinalizacion": actividades!.timeFinalizacion,
      "idArg": actividades!.idArg
    };

    try {
      final activities = EndPointApi.httpPut('/activities/${actividades!.idactividades}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }
}
