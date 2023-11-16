import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/lineaDeTiempo.dart';
import '../services/notifications_service.dart';

class LineaDeTiempoProvider extends ChangeNotifier {
  List<LineaDeTiempo> lineaDeTiempo = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  LineaDeTiempoProvider() {
    getLineaTiempo();
  }

  getLineaTiempo() async {
    lineaDeTiempo = [];
    List<dynamic> resp = await EndPointApi.httpGet('timeline');
    resp.forEach((element) => lineaDeTiempo.add(LineaDeTiempo.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }

  Future<LineaDeTiempo?> getLineaDeTiempoById(String id, String idgrupos) async {
    try {
      final resp = await EndPointApi.httpGet('timeline/$id/$idgrupos');
      final timeLine = LineaDeTiempo.fromMap(resp);
      return timeLine;
    } catch (e) {
      NotificationsService.showSnackbarError('Linea de tiempo no existe');
      return null;
    }
  }

  
  Future updateArg2(
      int idactividades,
      String fecharealizacion,
      String fechadefinalizacion,
      String timeinicial,
      String timeFinalizacion) async {
    // Petición put HTTP
    final data = {
      "idactividades": idactividades,
      "nombre": '',
      "descripcion": '',
      "fecharealizacion": fecharealizacion,
      "fechadefinalizacion": fechadefinalizacion,
      "idMedios": 0,
      "timeinicial": timeinicial,
      "timeFinalizacion": timeFinalizacion,
      "idArg": 0,
      "response": ''
    };
    EndPointApi.httpPut('activities/timeline/$idactividades', data).then((json) {
      lineaDeTiempo = lineaDeTiempo.map((arg) {
        if (arg.idactividades != idactividades) return arg;
        arg.idactividades = idactividades;
        arg.fecharealizacion = fecharealizacion;
        arg.fechadefinalizacion = fechadefinalizacion;
        arg.timeFinalizacion = timeFinalizacion;
        arg.timeinicial = timeinicial;
        return arg;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }

  void refreshArg(LineaDeTiempo newLineaTiempo) {
    lineaDeTiempo = lineaDeTiempo.map((arg) {
      if (arg.idarg == newLineaTiempo.idarg) return arg = newLineaTiempo;
      return arg;
    }).toList();

    notifyListeners();
  }

  disposeLineaTiempo() {
    lineaDeTiempo = [];
  }
}
