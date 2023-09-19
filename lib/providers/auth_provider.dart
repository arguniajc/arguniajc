import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/api/endpointApi.dart';
import 'package:control_actividades/router/router.dart';
import 'package:control_actividades/services/local_storage.dart';
import 'package:control_actividades/services/navigation_service.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? usuario;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    // Petición HTTP
    final data = {"email": email, "password": password};
    EndPointApi.httpPost('/user/auth', data).then((json) {
      usuario = Usuario.fromMap(json);
      final res = Usuario.fromMap(json);
      if (usuario!.response.isEmpty) {
        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', res.token);
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        EndPointApi.configureDio();
        notifyListeners();
      } else {
        NotificationsService.showSnackbarError(res.response);
      }
    }).catchError((e) {
      throw 'Error en la peticion auht';
    });
  }

  register(String name, String apellido, int documento, String email,
      String password) {
    // Petición post HTTP
    final data = {
      "documento": documento,
      "nombre": name,
      "apellido": apellido,
      "email": email,
      "password": password,
      "id_tipo_usuario": 1
    };

    EndPointApi.httpPost('/user', data).then((json) {
      usuario = Usuario.fromMap(json);
      if (usuario!.response.isEmpty) {
        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', usuario!.token);
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        EndPointApi.configureDio();
        notifyListeners();
      } else {
        NotificationsService.showSnackbarError(usuario!.response);
      }
    }).catchError((e) {
      throw 'Error en la peticion auht';
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await EndPointApi.httpGet('user/auth/$token');
      usuario = Usuario.fromMap(resp);
      //linea comentada video 137 del curso revisar
      //LocalStorage.prefs.setString('token', res.token);
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    // ir al backend y comprobar si el JWT es válido
    //await Future.delayed(Duration(milliseconds: 1000));
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
