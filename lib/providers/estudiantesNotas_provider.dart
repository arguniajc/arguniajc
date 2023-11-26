import 'package:control_actividades/Models/http/UsuariosEstudiantes.dart';
import 'package:control_actividades/Models/http/estudiantesnotas.dart';
import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';

class EstudiantesNotasProvider extends ChangeNotifier {
  List<EstudianteNotas> estudiantesNotas = [];
  bool ascending = true;
  int? sortColumnIndex;

  getEstudiantesNotas(String id) async {
    estudiantesNotas = [];
    List<dynamic> resp = await EndPointApi.httpGet('infoestudiantes/$id');
    resp.forEach((element) => estudiantesNotas.add(EstudianteNotas.fromJson(element)));
    notifyListeners();
  }

  // Future<ActividadesArg?> getActivitiesArgById(String id) async {
  //   try {
  //     final resp = await EndPointApi.httpGet('activities/$id');
  //     final actividadesArg = ActividadesArg.fromJson(resp);
  //     return actividadesArg;
  //   } catch (e) {
  //     NotificationsService.showSnackbarError('activities no existe');
  //     return null;
  //   }
  // }

  // Future newArg(
  //     int idactividades,
  //     String nombre,
  //     String descripcion,
  //     int idMedios,
  //     String timeinicial,
  //     String timeFinalizacion,
  //     int idArg,
  //     String tokenUser,
  //     List<ActividadesGrupo> grupos) async {
  //   // Petición post HTTP
  //   final data = {
  //     "idactividades": 0,
  //     "nombre": nombre,
  //     "descripcion": descripcion,
  //     "idMedios": idMedios,
  //     "timeinicial": timeinicial,
  //     "timeFinalizacion": timeFinalizacion,
  //     "idArg": idArg,
  //     "tokenUser": tokenUser,
  //     "response": '',
  //     "actividadesGrupos": grupos,
  //     "nombre_grupo": '',
  //     "correo_profesor": '',
  //     "nombre_arg": '',
  //     "descripcion_actividad": '',
  //     "tipo_medio": '',
  //     "fecha_realizacion": ''
  //   };
  //   EndPointApi.httpPost('activities', data).then((json) {
  //     final res = ActividadesArg.fromJson(json);
  //     if (res.response.isNotEmpty) {
  //       NotificationsService.showSnackbarError('Actividades ya Existe');
  //     } else {
  //       activitiesArgs.add(res);
  //       NotificationsService.showSnackbar('Arg ${res.nombre} creado');
  //     }

  //     notifyListeners();
  //   }).catchError((e) {
  //     throw 'Error en la peticion Post';
  //   });
  // }

  Future updateNota(
      double nota,
      int idActividad,
      int idEstudiante) async {
    // Petición put HTTP
    EndPointApi.httpPutSinBody('infoestudiantes/$idEstudiante/$idActividad/$nota').then((json) {
      estudiantesNotas = estudiantesNotas.map((arg) {
        if (arg.idActividad != idActividad) return arg;
        arg.fechaCalificacion = DateTime.now();
        arg.nota = nota;
        return arg;
      }).toList();
      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }
  
  // Future deleteActividadesArg(int id) async {
  //   EndPointApi.httpDelete('activities/$id').then((json) {
  //     activitiesArgs.removeWhere((element) => element.idactividades == id);

  //     notifyListeners();
  //   }).catchError((e) {
  //     throw 'Error en la peticion Delete';
  //   });
  // }

  void sort<T>(Comparable<T> Function(EstudianteNotas arg) getField) {
    estudiantesNotas.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshArg(EstudianteNotas newUser) {
    estudiantesNotas = estudiantesNotas.map((user) {
      if (user.idUsuario == newUser.idUsuario) return user = newUser;
      return user;
    }).toList();

    notifyListeners();
  }
}
