import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/SedeArg.dart';
import '../services/notifications_service.dart';

class SedeProvider extends ChangeNotifier {
  List<SedeArg> sedeArgs = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  SedeProvider() {
    getSede();
  }

  getSede() async {
    sedeArgs = [];
    List<dynamic> resp = await EndPointApi.httpGet('sede');
    resp.forEach((element) => sedeArgs.add(SedeArg.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }

  Future<SedeArg?> getSedeById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('sede/$id');
      final argsSede = SedeArg.fromMap(resp);
      return argsSede;
    } catch (e) {
      NotificationsService.showSnackbarError('Sede no existe');
      return null;
    }
  }

  Future newSede(
      String nombre,
      String tipoSede,
      String descripcion) async {
    // Petición post HTTP
    final data = {
      "idUniversidad": 0,
      "nombre": nombre,
      "tipo_sede": tipoSede,
      "descripcion": descripcion,
      "response": '',
    };

    EndPointApi.httpPost('sede', data).then((json) {
      final res = SedeArg.fromMap(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError('Sede ya Existe');
      } else {
        sedeArgs.add(res);
        NotificationsService.showSnackbar('Sede ${res.nombre} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateSede(
      int idUniversidad,
      String nombre,
      String tipoSede,
      String descripcion) async {
    // Petición put HTTP
    final data = {
      "idUniversidad": idUniversidad,
      "nombre": nombre,
      "tipo_sede": tipoSede,
      "descripcion": descripcion,
      "response": '',
    };

    EndPointApi.httpPut('sede/$idUniversidad', data).then((json) {
      sedeArgs = sedeArgs.map((sd) {
        if (sd.idUniversidad != idUniversidad) return sd;
        sd.idUniversidad = idUniversidad;
        sd.nombre = nombre;
        sd.tipoSede = tipoSede;
        sd.descripcion = descripcion;
        sd.response = '';
        return sd;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }  

  Future deleteSede(int id) async {
    EndPointApi.httpDelete('sede/$id').then((json) {
      sedeArgs.removeWhere((element) => element.idUniversidad == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(SedeArg arg) getField) {
    sedeArgs.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshSede(SedeArg newArg) {
    sedeArgs = sedeArgs.map((arg) {
      if (arg.idUniversidad == newArg.idUniversidad) return arg = newArg;
      return arg;
    }).toList();

    notifyListeners();
  }
}
