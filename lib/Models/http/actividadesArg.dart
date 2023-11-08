import 'dart:convert';

class ActividadesArg {
  int idactividades;
  String nombre;
  String descripcion;
  String fecharealizacion;
  String fechadefinalizacion;
  int idMedios;
  String timeinicial;
  String timeFinalizacion;
  int idArg;
  String response;

  ActividadesArg({
    required this.idactividades,
    required this.nombre,
    required this.descripcion,
    required this.fecharealizacion,
    required this.fechadefinalizacion,
    required this.idMedios,
    required this.timeinicial,
    required this.timeFinalizacion,
    required this.idArg,
    required this.response
  });

  factory ActividadesArg.fromJson(String str) => ActividadesArg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadesArg.fromMap(Map<String, dynamic> json) => ActividadesArg(
        idactividades: json["idactividades"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fecharealizacion: json["fecharealizacion"],
        fechadefinalizacion: json["fechadefinalizacion"],
        idMedios: json["idMedios"],
        timeinicial: json["timeinicial"],
        timeFinalizacion: json["timeFinalizacion"],
        idArg: json["idArg"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idactividades": idactividades,
        "nombre": nombre,
        "descripcion": descripcion,
        "fecharealizacion": fecharealizacion,
        "fechadefinalizacion": fechadefinalizacion,
        "idMedios": idMedios,
        "timeinicial": timeinicial,
        "timeFinalizacion": timeFinalizacion,
        "idArg": idArg,
        "response": response,
      };

  @override
  String toString() {
    return 'ActividadesArg: $idactividades $nombre';
  }
}
