import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/Profesor.dart';
import '../services/notifications_service.dart';




class ProfesoresProvider extends ChangeNotifier {
  List<Profesor> profesores = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  ProfesoresProvider() {
    GetProfesores();
  }

  GetProfesores() async {
    profesores = [];
    List<dynamic> resp = await EndPointApi.httpGet('profesores');
    resp.forEach((element) => profesores.add(Profesor.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }


}
