import 'package:flutter/material.dart';
import 'package:control_actividades/api/endpointApi.dart';
import '../Models/http/TypeUser.dart';

class TypeRegisterTokenModalProvider extends ChangeNotifier {
  List<TypeUser> typeUsers = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  TypeRegisterTokenModalProvider() {
    getTypeUsers();
  }

  getTypeUsers() async {
    typeUsers = [];
    List<dynamic> resp = await EndPointApi.httpGet('typeuser');
    resp.forEach((element) =>  typeUsers.add(TypeUser.fromMap(element)));
    typeUsers = typeUsers.where((value) => value.descripcion != 'admin' && value.descripcion != 'Puppetmaster Creador').toList();
    isLoading = false;
    notifyListeners();
  }
}
