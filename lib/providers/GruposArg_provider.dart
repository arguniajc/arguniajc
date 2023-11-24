import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/GruposArg.dart';
import '../services/notifications_service.dart';
import 'dart:html' as html;
import 'dart:async';

class GruposProvider extends ChangeNotifier {
  List<GruposArg> gruposArgs = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  GruposProvider() {
    getGrupos();  
  }


  getGrupos() async {
    gruposArgs = [];
    List<dynamic> resp = await EndPointApi.httpGet('grupos');
    resp.forEach((element) => gruposArgs.add(GruposArg.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }

  Future<GruposArg?> getGruposById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('grupos/$id');
      final argsGrupos = GruposArg.fromMap(resp);
      return argsGrupos;
    } catch (e) {
      NotificationsService.showSnackbarError('Grupos no existe');
      return null;
    }
  }

  Future newGrupos(
    String nombreGrupo,
    int idArg,
    int idSede,
    int idProfesor,
    String profesorNombre,
    String respuesta,
  ) async {
    // Petición post HTTP
    final data = {
      "idGrupos": 0,
      "nombreGrupo": nombreGrupo,
      "idArg": idArg,
      "idProfesor": idProfesor,
      "idSede": idSede,
      "nombreSede": '',
      "titulo": '',
      "profesorNombre": profesorNombre,
      "tokenGrupo": '',
      "respuesta": respuesta,
    };

    Future<void> reloadPageAfterDelay() async {
      await Future.delayed(const Duration(seconds: 1));
      html.window.location.reload();
    }

    EndPointApi.httpPost('grupos', data).then((json) {
      final res = GruposArg.fromMap(json);
      if (res.respuesta.isNotEmpty) {
        NotificationsService.showSnackbarError('Grupos ya Existe');
      } else {
        gruposArgs.add(res);
        NotificationsService.showSnackbar('Arg ${res.nombreGrupo} creado');
        reloadPageAfterDelay();
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateGrupos(int idGrupos, String nombreGrupo, int idArg,
      int idProfesor, int idSede, String respuesta) async {
    // Petición put HTTP
    final data = {
      "idGrupos": idGrupos,
      "nombreGrupo": nombreGrupo,
      "idArg": idArg,
      "idProfesor": idProfesor,
      "idSede": idSede,
      "nombreSede": '',
      "titulo": '',
      "profesorNombre": '',
      "tokenGrupo": '',
      "respuesta": respuesta,
    };

    EndPointApi.httpPut('/grupos/$idGrupos', data).then((json) {
      gruposArgs = gruposArgs.map((grupo) {
        if (grupo.idGrupos != idGrupos) return grupo;
        grupo.idArg = idArg;
        grupo.nombreGrupo = nombreGrupo;
        grupo.idProfesor = idProfesor;
        grupo.idSede = idSede;
        grupo.respuesta = '';
        return grupo;
      }).toList();

      notifyListeners();
  
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
 
  }

  Future deleteGrupos(int id) async {
    EndPointApi.httpDelete('grupos/$id').then((json) {
      gruposArgs.removeWhere((element) => element.idGrupos == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(GruposArg arg) getField) {
    gruposArgs.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshGrupos(GruposArg newArg) {
    gruposArgs = gruposArgs.map((arg) {
      if (arg.idArg == newArg.idArg) return arg = newArg;
      return arg;
    }).toList();

    notifyListeners();
  }
}
