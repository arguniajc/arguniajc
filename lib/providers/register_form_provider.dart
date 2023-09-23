import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String apellido = '';
  int documento = 0;
  int? token;

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valid ... Login');
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}
