import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/TypeUser.dart';
import '../services/notifications_service.dart';

class TypeUsersProvider extends ChangeNotifier {
  List<TypeUser> typeUsers = [];

  getUsers() async {
    typeUsers = [];
    List<dynamic> resp = await EndPointApi.httpGet('typeuser');
    resp.forEach((element) => typeUsers.add(TypeUser.fromMap(element)));
    notifyListeners();
  }

  getTypeUsers() async {
    typeUsers = [];
    List<dynamic> resp = await EndPointApi.httpGet('typeuser');
    resp.forEach((element) => typeUsers.add(TypeUser.fromMap(element)));
    notifyListeners();
    return typeUsers;
  }

  Future newUser(String descripcion) async {
    final data = {
      "idTypeUser": 0,
      "descripcion": descripcion,

    };

    EndPointApi.httpPost('/typeuser', data).then((json) {
      final res = TypeUser.fromMap(json);
      if (res.response.isNotEmpty) {
        NotificationsService.showSnackbarError(
            'type usuario ya Existe');
      } else {
        typeUsers.add(res);
        NotificationsService.showSnackbar(
            'Usuario ${res.descripcion} creado');
      }

      notifyListeners();
    }).catchError((e) {
      throw 'Error en la peticion Post';
    });
  }

  Future updateUser(
      int id,
      String descripcion,
      String response) async {
    final data = {
      "idTypeUser": id,
      "descripcion": descripcion,
      "response": response
    };

    EndPointApi.httpPut('/typeuser/$id', data).then((json) {
      typeUsers = typeUsers.map((type) {
        if (type.idTypeUser != id) return type;
        type.idTypeUser = id;
        type.descripcion = descripcion;
        return type;
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
}
