import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/actividadesArg.dart';
import '../services/notifications_service.dart';

class ActividadesArgProvider extends ChangeNotifier {
  List<ActividadesArg> activitiesArgs = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  ActividadesArgProvider() {
    getActividades();
  }

  getActividades() async {
    activitiesArgs = [];
    List<dynamic> resp = await EndPointApi.httpGet('activities');
    activitiesArgs = resp.map((element) => ActividadesArg.fromJson(element)).toList();
    isLoading = false;
    notifyListeners();
  }

  Future<ActividadesArg?> getActivitiesArgById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('activities/$id');
      final actividadesArg = ActividadesArg.fromJson(resp);
      return actividadesArg;
    } catch (e) {
      NotificationsService.showSnackbarError('activities no existe');
      return null;
    }
  }

  Future newArg(
      int idactividades,
      String nombre,
      String descripcion,
      int idMedios,
      String timeinicial,
      String timeFinalizacion,
      int idArg,
      String tokenUser,
      List<ActividadesGrupo> grupos) async {
    // Petición post HTTP
    final data = {
      "idactividades": 0,
      "nombre": nombre,
      "descripcion": descripcion,
      "idMedios": idMedios,
      "timeinicial": timeinicial,
      "timeFinalizacion": timeFinalizacion,
      "idArg": idArg,
      "tokenUser": tokenUser,
      "response": '',
      "actividadesGrupos": grupos,
      "nombre_grupo": '',
      "correo_profesor": '',
      "nombre_arg": '',
      "descripcion_actividad": '',
      "tipo_medio": '',
      "fecha_realizacion": ''
    };
    EndPointApi.httpPost('activities', data).then((json) {
      final res = ActividadesArg.fromJson(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError('Actividades ya Existe');
      } else {
        activitiesArgs.add(res);
        NotificationsService.showSnackbar('Arg ${res.nombre} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateArg(
      int idactividades,
      String nombre,
      String descripcion,
      int idMedios,
      String timeinicial,
      String timeFinalizacion,
      int idArg,
      String tokenUser,
      List<ActividadesGrupo> grupos) async {
    // Petición put HTTP
    final data = {
      "idactividades": idactividades,
      "nombre": nombre,
      "descripcion": descripcion,
      "idMedios": idMedios,
      "timeinicial": timeinicial,
      "timeFinalizacion": timeFinalizacion,
      "idArg": idArg,
      "tokenUser": tokenUser,
      "response": '',
      "actividadesGrupos": grupos,
      "nombre_grupo": '',
      "correo_profesor": '',
      "nombre_arg": '',
      "descripcion_actividad": '',
      "tipo_medio": '',
      "fecha_realizacion": ''
    };
    EndPointApi.httpPut('activities/$idactividades', data).then((json) {
      activitiesArgs = activitiesArgs.map((arg) {
        if (arg.idactividades != idactividades) return arg;
        arg.idactividades = idactividades;
        arg.nombre = nombre;
        arg.descripcion = descripcion;
        arg.timeinicial = timeinicial;
        arg.timeFinalizacion = timeFinalizacion;
        arg.idMedios = idMedios;
        return arg;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }
  
  Future deleteActividadesArg(int id) async {
    EndPointApi.httpDelete('activities/$id').then((json) {
      activitiesArgs.removeWhere((element) => element.idactividades == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  Future deleteActividadesArg2(int idActividades, int id) async {
    EndPointApi.httpDelete('activities/$id/edit').then((json) {
      activitiesArgs = activitiesArgs.map((e) {
        if (e.idactividades != idActividades) return e;
        e.actividadesGrupos.removeWhere((element) => element.idactividadesGrupos == id);
        return e;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(ActividadesArg arg) getField) {
    activitiesArgs.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshArg(ActividadesArg newArg) {
    activitiesArgs = activitiesArgs.map((arg) {
      if (arg.idactividades == newArg.idactividades) return arg = newArg;
      return arg;
    }).toList();

    notifyListeners();
  }
}
