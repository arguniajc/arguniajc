import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/auth_response.dart';
import '../services/notifications_service.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  UsersProvider() {
    getUsers();
  }

  getUsers() async {
    users = [];
    List<dynamic> resp = await EndPointApi.httpGet('user');
    resp.forEach((element) => {users.add(Usuario.fromMap(element))});
    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserById(String documento) async {
    try {
      final resp = await EndPointApi.httpGet('user/$documento');
      final user = Usuario.fromMap(resp);
      return user;
    } catch (e) {
      NotificationsService.showSnackbarError('Usuario no existe');
      return null;
    }
  }

  Future newUser(String name, String apellido, int documento, String email,
      String password) async {
    // Petición post HTTP
    final data = {
      "documento": documento,
      "nombre": name,
      "apellido": apellido,
      "email": email,
      "password": password,
      "id_tipo_usuario": 1,
    };

    EndPointApi.httpPost('/user', data).then((json) {
      final res = Usuario.fromMap(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError(
            'Usuario email o Documento ya Existe');
      } else {
        users.add(res);
        NotificationsService.showSnackbar(
            'Usuario ${res.nombre} ${res.apellido} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateUser(
      int id,
      String name,
      String apellido,
      int documento,
      String email,
      String password,
      String response,
      String token,
      String img) async {
    // Petición put HTTP
    final data = {
      "documento": documento,
      "nombre": name,
      "apellido": apellido,
      "email": email,
      "password": password,
      "id_tipo_usuario": 1,
      "response": response,
      "token": token,
      "img": img
    };

    EndPointApi.httpPut('/user/$id', data).then((json) {
      users = users.map((user) {
        if (user.idusuario != id) return user;
        user.nombre = name;
        user.apellido = apellido;
        user.documento = documento;
        user.email = email;
        user.password = password;
        return user;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }

  Future deleteUser(int id) async {
    EndPointApi.httpDelete('/user/$id').then((json) {
      users.removeWhere((element) => element.idusuario == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    users = users.map((user) {
      if (user.idusuario == newUser.idusuario) return user = newUser;
      return user;
    }).toList();

    notifyListeners();
  }
}
