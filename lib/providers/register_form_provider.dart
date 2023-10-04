import 'package:flutter/material.dart';
import '../Models/http/infArg.dart';
import 'package:control_actividades/api/endpointApi.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String apellido = '';
  int documento = 0;
  InfArg? args;

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validarToken(String token) async {
    try {
      if (token.isNotEmpty) {
        final resp = await EndPointApi.httpGet('arg/token/$token');
        final arg = InfArg.fromMap(resp);
        args = arg;
        if (arg.idarg != 0) {
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
