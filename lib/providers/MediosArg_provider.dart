import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/MediosArg.dart';
import '../services/notifications_service.dart';

class MediosProvider extends ChangeNotifier {
  List<MediosArg> mediosArgs = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  MediosProvider() {
    getMedios();
  }

  getMedios() async {
    mediosArgs = [];
    List<dynamic> resp = await EndPointApi.httpGet('medios');
    resp.forEach((element) => mediosArgs.add(MediosArg.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }

  Future<MediosArg?> getMediosById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('medios/$id');
      final argsMedios = MediosArg.fromMap(resp);
      return argsMedios;
    } catch (e) {
      NotificationsService.showSnackbarError('medios no existe');
      return null;
    }
  }

  Future neMedios(
      String nombre,
      String tipoMedio,
      String medionotificacion,
      String tokenUser) async {
    // Petición post HTTP
    final data = {
      "idMedios": 0,
      "nombre": nombre,
      "tipoMedio": tipoMedio,
      "medionotificacion": medionotificacion,
      "tokenUser": tokenUser,
      "response": '',
    };

    EndPointApi.httpPost('/medios', data).then((json) {
      final res = MediosArg.fromMap(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError('Medios ya Existe');
      } else {
        mediosArgs.add(res);
        NotificationsService.showSnackbar('Arg ${res.nombre} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateMedios(
      int idMedios,
      String nombre,
      String tipoMedio,
      String medionotificacion,
      String tokenUser) async {
    // Petición put HTTP
    final data = {
      "idMedios": idMedios,
      "nombre": nombre,
      "tipoMedio": tipoMedio,
      "medionotificacion": medionotificacion,
      "tokenUser": tokenUser,
      "response": ''
    };

    EndPointApi.httpPut('/medios/$idMedios', data).then((json) {
      mediosArgs = mediosArgs.map((md) {
        if (md.idMedios != idMedios) return md;
        md.idMedios = idMedios;
        md.nombre = nombre;
        md.tipoMedio = tipoMedio;
        md.medionotificacion = medionotificacion;
        md.response = '';
        return md;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }

  Future deleteMedios(int id) async {
    EndPointApi.httpDelete('/medios/$id').then((json) {
      mediosArgs.removeWhere((element) => element.idMedios == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(MediosArg arg) getField) {
    mediosArgs.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshMedios(MediosArg newMedio) {
    mediosArgs = mediosArgs.map((medio) {
      if (medio.idMedios == newMedio.idMedios) return medio = newMedio;
      return medio;
    }).toList();

    notifyListeners();
  }
}
