import 'dart:convert';

class SedeArg {
  int idUniversidad;
	String nombre;
  String tipoSede;
  String descripcion;
  String response;
  

  SedeArg({
    required this.idUniversidad,
    required this.nombre,
    required this.tipoSede,
    required this.descripcion,
    required this.response
  });

  factory SedeArg.fromJson(String str) => SedeArg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SedeArg.fromMap(Map<String, dynamic> json) => SedeArg(
        idUniversidad: json["idUniversidad"],
        nombre: json["nombre"],
        tipoSede: json["tipo_sede"],
        descripcion: json["descripcion"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => { 
        "idUniversidad": idUniversidad,
        "nombre": nombre,
        "tipo_sede": tipoSede,
        "descripcion": descripcion,
        "response": response,
      };

  @override
  String toString() {
    return 'SedeArg: $idUniversidad $nombre';
  }
}
