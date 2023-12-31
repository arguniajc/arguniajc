import 'dart:convert';

class MediosArg {
  int idMedios;
  String nombre;
  String tipoMedio;
  String medionotificacion;
  String tokenUser;
  String response;


  MediosArg({
    required this.idMedios,
    required this.nombre,
    required this.tipoMedio,
    required this.medionotificacion,
    required this.tokenUser,
    required this.response
  });

  factory MediosArg.fromJson(String str) => MediosArg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MediosArg.fromMap(Map<String, dynamic> json) => MediosArg(
        idMedios: json["idMedios"],
        nombre: json["nombre"],
        tipoMedio: json["tipoMedio"],
        medionotificacion: json["medionotificacion"],
        tokenUser: json["tokenUser"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idMedios": idMedios,
        "nombre": nombre,
        "tipoMedio": tipoMedio,
        "medionotificacion": medionotificacion,
        "tokenUser": tokenUser,
        "response": response,
      };

  @override
  String toString() {
    return 'MediosArg: $idMedios $nombre';
  }
}
