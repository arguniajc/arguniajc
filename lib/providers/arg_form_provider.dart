import 'package:control_actividades/Models/http/infArg.dart';
import 'package:flutter/material.dart';
import '../api/endpointApi.dart';

class ArgFormProvider extends ChangeNotifier {
  InfArg? arg;

  late GlobalKey<FormState> formKey;

  void updateListener() {
    notifyListeners();
  }

  copyUserWith(
      {int? idarg,
      String? titulo,
      String? observaciones,
      String? areadeconocimiento,
      String? asignatura,
      String? modalidaddeestudio,
      String? coceptos,
      String? proposito,
      String? sinopsis,
      String? agujerodeconejo,
      String? jugabilidad,
      String? participantes,
      int? duracionaprox,
      String? entidad,
      String? pais,
      String? lugardeejecucion,
      int? idPuppetmaster,
      String? response}) {
    arg = InfArg(
        idarg: idarg ?? arg!.idarg,
        titulo: titulo ?? arg!.titulo,
        observaciones: observaciones ?? arg!.observaciones,
        areadeconocimiento: areadeconocimiento ?? arg!.areadeconocimiento,
        asignatura: asignatura ?? arg!.asignatura,
        modalidaddeestudio: modalidaddeestudio ?? arg!.modalidaddeestudio,
        coceptos: coceptos ?? arg!.coceptos,
        proposito: proposito ?? arg!.proposito,
        sinopsis: sinopsis ?? arg!.sinopsis,
        agujerodeconejo: agujerodeconejo ?? arg!.agujerodeconejo,
        jugabilidad: jugabilidad ?? arg!.jugabilidad,
        participantes: participantes ?? arg!.participantes,
        duracionaprox: duracionaprox ?? arg!.duracionaprox,
        entidad: entidad ?? arg!.entidad,
        pais: pais ?? arg!.pais,
        lugardeejecucion: lugardeejecucion ?? arg!.lugardeejecucion,
        idPuppetmaster: idPuppetmaster ?? arg!.idPuppetmaster,
        response: response ?? arg!.response);
    notifyListeners();
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }

  Future updateArg() async {
    if (!validForm()) {
      return false;
    }

    final data = {
      "idarg": arg!.idarg,
      "titulo": arg!.titulo,
      "observaciones": arg!.observaciones,
      "areadeconocimiento": arg!.areadeconocimiento,
      "asignatura": arg!.asignatura,
      "modalidaddeestudio": arg!.modalidaddeestudio,
      "coceptos": arg!.coceptos,
      "proposito": arg!.proposito,
      "sinopsis": arg!.sinopsis,
      "agujerodeconejo": arg!.agujerodeconejo,
      "jugabilidad": arg!.jugabilidad,
      "participantes": arg!.participantes,
      "duracionaprox": arg!.duracionaprox,
      "entidad": arg!.entidad,
      "pais": arg!.pais,
      "lugardeejecucion": arg!.lugardeejecucion,
      "id_puppetmaste": arg!.idPuppetmaster,
    };

    try {
      final args = EndPointApi.httpPut('/arg/${arg!.idarg}', data);

      return true;
    } catch (e) {
      throw 'Error en la peticion Put';
    }
  }
}
