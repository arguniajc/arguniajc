import 'package:control_actividades/Models/http/GruposArg.dart';
import 'package:flutter/material.dart';
import '../api/endpointApi.dart';

class GruposFormProvider extends ChangeNotifier {
  GruposArg? grupos;

  late GlobalKey<FormState> formKey;

  void updateListener() {
    notifyListeners();
  }


  copyUserWith(
    {int? idGrupos,
    String? nombreGrupo,
    int? idArg,
    int? idProfesor,
    String? nombreProfesor,
    int? idSede,
    String? nombreSede,
    String? titulo,
    String? respuesta}) {
    grupos = GruposArg(
      idGrupos: idGrupos ?? grupos!.idGrupos,
      nombreGrupo: nombreGrupo ?? grupos!.nombreGrupo,
      idArg: idArg ?? grupos!.idArg,
      idProfesor: idProfesor ?? grupos!.idProfesor,
      profesorNombre: nombreProfesor ?? grupos!.profesorNombre,
      idSede: idSede ?? grupos!.idSede,
      nombreSede: nombreSede ?? grupos!.nombreSede,
      titulo: titulo ?? grupos!.titulo,
      respuesta: respuesta ?? grupos!.respuesta
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
      "idGrupos": grupos!.idGrupos,
      "nombreGrupo": grupos!.nombreGrupo,
      "idArg": grupos!.idArg,
      "idProfesor": grupos!.idProfesor,
      "profesorNombre": grupos!.profesorNombre,
      "idSede": grupos!.idSede,
      "nombreSede": grupos!.nombreSede,
      "titulo": grupos!.titulo,
      "respuesta": grupos!.respuesta,
    };

//hola

    try {
      final grupo = EndPointApi.httpPut('grupos/${grupos!.idGrupos}', data);
      return true;
    } catch (e) {
      throw 'Error en la peticion Put.';

    }
  }
}
