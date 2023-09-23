import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/actividadesArg.dart';
import '../services/notifications_service.dart';

class searchArgTokenProvider extends ChangeNotifier {
  ActividadesArg? activitiesArgs;

  searchArgTokenProvider() {}

  getActividades(int token) async {
    // resp = await EndPointApi.httpGet('argToken/token');
    // resp.forEach((element) => {activitiesArgs.add(ActividadesArg.fromMap(element))});
    // notifyListeners();
  }
}
