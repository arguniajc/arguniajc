import 'dart:convert';

class Usuario {
  int idusuario;
  int documento;
  String nombre;
  String apellido;
  String email;
  String password;
  int idTipoUsuario;
  String response;
  String token;
  String? img;

  Usuario(
      {required this.idusuario,
      required this.documento,
      required this.nombre,
      required this.apellido,
      required this.email,
      required this.password,
      required this.idTipoUsuario,
      required this.response,
      required this.token,
      this.img});

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        idusuario: json["idusuario"],
        documento: json["documento"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        password: json["password"],
        idTipoUsuario: json["id_tipo_usuario"],
        response: json["response"],
        token: json["token"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "idusuario": idusuario,
        "documento": documento,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "password": password,
        "id_tipo_usuario": idTipoUsuario,
        "response": response,
        "token": token,
        "img": img,
      };

  @override
  String toString() {
    return 'Usuario: $nombre $apellido';
  }
}
