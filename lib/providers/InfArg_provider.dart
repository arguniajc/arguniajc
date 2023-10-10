import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/infArg.dart';
import '../services/notifications_service.dart';

class InfArgProvider extends ChangeNotifier {
  List<InfArg> args = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  InfArgProvider() {
    getArg();
  }

  getArg() async {
    args = [];
    List<dynamic> resp = await EndPointApi.httpGet('arg');
    resp.forEach((element) => args.add(InfArg.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }

  Future<InfArg?> getArgById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('arg/$id');
      final arg = InfArg.fromMap(resp);
      return arg;
    } catch (e) {
      NotificationsService.showSnackbarError('Arg no existe');
      return null;
    }
  }

  Future newArg(
      String titulo,
      String observaciones,
      String areadeconocimiento,
      String asignatura,
      String modalidaddeestudio,
      String coceptos,
      String proposito,
      String sinopsis,
      String agujerodeconejo,
      String jugabilidad,
      String participantes,
      String duracionaprox,
      String entidad,
      String pais,
      String lugardeejecucion,
      int idPuppetmaster) async {
    // Petición post HTTP
    final data = {
      "idarg": 0,
      "titulo": titulo,
      "observaciones": observaciones,
      "areadeconocimiento": areadeconocimiento,
      "asignatura": asignatura,
      "modalidaddeestudio": modalidaddeestudio,
      "coceptos": coceptos,
      "proposito": proposito,
      "sinopsis": sinopsis,
      "agujerodeconejo": agujerodeconejo,
      "jugabilidad": jugabilidad,
      "participantes": participantes,
      "duracionaprox": duracionaprox,
      "entidad": entidad,
      "pais": pais,
      "lugardeejecucion": lugardeejecucion,
      "idPuppetmaster": idPuppetmaster,
      "response": ''
    };

    EndPointApi.httpPost('/arg', data).then((json) {
      final res = InfArg.fromMap(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError('Arg ya Existe');
      } else {
        args.add(res);
        NotificationsService.showSnackbar('Arg ${res.titulo} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateArg(
      int idarg,
      String titulo,
      String observaciones,
      String areadeconocimiento,
      String asignatura,
      String modalidaddeestudio,
      String coceptos,
      String proposito,
      String sinopsis,
      String agujerodeconejo,
      String jugabilidad,
      String participantes,
      String duracionaprox,
      String entidad,
      String pais,
      String lugardeejecucion,
      int idPuppetmaster) async {
    // Petición put HTTP
    final data = {
      "idarg": idarg,
      "titulo": titulo,
      "observaciones": observaciones,
      "areadeconocimiento": areadeconocimiento,
      "asignatura": asignatura,
      "modalidaddeestudio": modalidaddeestudio,
      "coceptos": coceptos,
      "proposito": proposito,
      "sinopsis": sinopsis,
      "agujerodeconejo": agujerodeconejo,
      "jugabilidad": jugabilidad,
      "participantes": participantes,
      "duracionaprox": duracionaprox,
      "entidad": entidad,
      "pais": pais,
      "lugardeejecucion": lugardeejecucion,
      "id_puppetmaste": idPuppetmaster,
      "response": ''
    };

    EndPointApi.httpPut('/arg/$idarg', data).then((json) {
      args = args.map((arg) {
        if (arg.idarg != idarg) return arg;
        arg.idarg = idarg;
        arg.titulo = titulo;
        arg.observaciones = observaciones;
        arg.areadeconocimiento = areadeconocimiento;
        arg.asignatura = asignatura;
        arg.modalidaddeestudio = modalidaddeestudio;
        arg.coceptos = coceptos;
        arg.proposito = proposito;
        arg.sinopsis = sinopsis;
        arg.agujerodeconejo = agujerodeconejo;
        arg.jugabilidad = jugabilidad;
        arg.participantes = participantes;
        arg.duracionaprox = duracionaprox;
        arg.entidad = entidad;
        arg.pais = pais;
        arg.lugardeejecucion = lugardeejecucion;
        arg.idPuppetmaster = idPuppetmaster;
        return arg;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }

  Future deleteArg(int id) async {
    EndPointApi.httpDelete('/arg/$id').then((json) {
      args.removeWhere((element) => element.idarg == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(InfArg arg) getField) {
    args.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshArg(InfArg newArg) {
    args = args.map((arg) {
      if (arg.idarg == newArg.idarg) return arg = newArg;
      return arg;
    }).toList();

    notifyListeners();
  }
}
