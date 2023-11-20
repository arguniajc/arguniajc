import 'dart:convert';

class TypeUser {
  int idTypeUser;
  String descripcion;
  String response;


  TypeUser({
    required this.idTypeUser,
    required this.descripcion,
    required this.response,
  });

  factory TypeUser.fromJson(String str) => TypeUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeUser.fromMap(Map<String, dynamic> json) => TypeUser(
        idTypeUser: json["idTypeUser"],
        descripcion: json["descripcion"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idTypeUser": idTypeUser,
        "descripcion": descripcion,
        "response": response
      };

  @override
  String toString() {
    return 'MediosArg: $idTypeUser $descripcion';
  }
}
