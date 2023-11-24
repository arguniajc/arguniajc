import 'dart:convert';

class TypeUser {
  int idTypeUser;
  String descripcion;
  String response;
  String tokenTUser;

  TypeUser({
    required this.idTypeUser,
    required this.descripcion,
    required this.tokenTUser,
    required this.response,
  });

  factory TypeUser.fromJson(String str) => TypeUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeUser.fromMap(Map<String, dynamic> json) => TypeUser(
        idTypeUser: json["idTypeUser"],
        descripcion: json["descripcion"],
        tokenTUser: json["tokenTUser"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idTypeUser": idTypeUser,
        "descripcion": descripcion,
        "tokenTUser": tokenTUser,
        "response": response
      };

  @override
  String toString() {
    return 'MediosArg: $idTypeUser $descripcion';
  }
}
