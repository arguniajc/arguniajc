
import 'dart:convert';

class Profesor {
  int idProfesor;
	String nombreApellido;
  String response;

  Profesor({
    required this.idProfesor,
    required this.nombreApellido,
    required this.response
  });

  factory Profesor.fromJson(String str) => Profesor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profesor.fromMap(Map<String, dynamic> json) => Profesor(
        idProfesor: json["idProfesor"],
        nombreApellido: json["nombreApellido"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idProfesor": idProfesor,
        "nombreApellido": nombreApellido,
        "response": response, 
      };

  @override
  String toString() {
    return 'Profesor: $idProfesor $nombreApellido';
  }
}
