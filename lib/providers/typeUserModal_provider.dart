import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/TypeUser.dart';
import '../services/notifications_service.dart';

class TypeUserModalProvider extends ChangeNotifier {
  List<TypeUser> typeUsers = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  TypeUserModalProvider() {
    getTypeUsers();
  }

  getTypeUsers() async {
    typeUsers = [];
    List<dynamic> resp = await EndPointApi.httpGet('typeuser');
    resp.forEach((element) => typeUsers.add(TypeUser.fromMap(element)));
    isLoading = false;
    notifyListeners();
  }

  Future<TypeUser?> getTipoUserById(String id) async {
    try {
      final resp = await EndPointApi.httpGet('typeuser/$id');
      final tipo = TypeUser.fromMap(resp);
      return tipo;
    } catch (e) {
      NotificationsService.showSnackbarError('Usuario no existe');
      return null;
    }
  }

  Future newTypeUser(String descripcion) async {
    // Petición post HTTP
    final data = {
     "idTypeUser": 0,
      "descripcion": descripcion,
    };

    EndPointApi.httpPost('/typeuser', data).then((json) {
      final res = TypeUser.fromMap(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError(
            'Tipo de Usuario ya Existe');
      } else {
        typeUsers.add(res);
        NotificationsService.showSnackbar(
            'Tipo de usuario ${res.descripcion} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateTypeUser(
      int id,
      String descripcion) async {
    // Petición put HTTP
    final data = {
      "idTypeUser": id,
      "descripcion": descripcion,
      "response": '',
    };

    EndPointApi.httpPut('/typeuser/$id', data).then((json) {
      typeUsers = typeUsers.map((tipo) {
        if (tipo.idTypeUser != id) return tipo;
        tipo.idTypeUser = id;
        tipo.descripcion = descripcion;
        return tipo;
      }).toList();

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Put';
    });
  }

  Future deleteUser(int id) async {
    EndPointApi.httpDelete('/typeuser/$id').then((json) {
      typeUsers.removeWhere((element) => element.idTypeUser == id);

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Delete';
    });
  }

  void sort<T>(Comparable<T> Function(TypeUser tipo) getField) {
    typeUsers.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshUser(TypeUser newUser) {
    typeUsers = typeUsers.map((user) {
      if (user.idTypeUser == newUser.idTypeUser) return user = newUser;
      return user;
    }).toList();

    notifyListeners();
  }
}
