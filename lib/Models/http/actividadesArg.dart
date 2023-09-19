import 'dart:convert';

class ActividadesArg {
  int idactividades;
  String medios;
  DateTime fecharealizacion;
  String nombre;
  String descripcion;
  int idMedios;
  String response;

  ActividadesArg({
    required this.idactividades,
    required this.medios,
    required this.fecharealizacion,
    required this.nombre,
    required this.descripcion,
    required this.idMedios,
    required this.response
  });

  factory ActividadesArg.fromJson(String str) => ActividadesArg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadesArg.fromMap(Map<String, dynamic> json) => ActividadesArg(
        idactividades: json["idactividades"],
        medios: json["medios"],
        fecharealizacion: json["fecharealizacion"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        idMedios: json["idMedios"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idactividades": idactividades,
        "medios": medios,
        "fecharealizacion": fecharealizacion,
        "nombre": nombre,
        "descripcion": descripcion,
        "idMedios": idMedios,
        "response": response,
      };

  @override
  String toString() {
    return 'ActividadesArg: $idactividades $nombre';
  }
}
