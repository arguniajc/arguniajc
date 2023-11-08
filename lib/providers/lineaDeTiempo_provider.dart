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

  Future<LineaDeTiempo?> getLineaDeTiempoById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('timeline/$id');
      final timeLine = LineaDeTiempo.fromMap(resp);
      return timeLine;
    } catch (e) {
      NotificationsService.showSnackbarError('Linea de tiempo no existe');
      return null;
    }
  }

  void refreshArg(LineaDeTiempo newLineaTiempo) {
    lineaDeTiempo = lineaDeTiempo.map((arg) {
      if (arg.idarg == newLineaTiempo.idarg) return arg = newLineaTiempo;
      return arg;
    }).toList();

    notifyListeners();
  }
}
