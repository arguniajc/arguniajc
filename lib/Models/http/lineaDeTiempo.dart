import 'dart:convert';

class LineaDeTiempo {
  int idactividades;
  String nombreActividad;
  String descripcionActividad;
  String fecharealizacion;
  String fechadefinalizacion;
  String timeinicial;
  String timeFinalizacion;
  int idarg;
  String titulo;
  String lugardeejecucion;
  String ciudad;
  int idmedios;
  String nombreMedio;

  LineaDeTiempo({
    required this.idactividades,
    required this.nombreActividad,
    required this.descripcionActividad,
    required this.fecharealizacion,
    required this.fechadefinalizacion,
    required this.timeinicial,
    required this.timeFinalizacion,
    required this.idarg,
    required this.titulo,
    required this.lugardeejecucion,
    required this.ciudad,
    required this.idmedios,
    required this.nombreMedio
  });

  factory LineaDeTiempo.fromJson(String str) => LineaDeTiempo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineaDeTiempo.fromMap(Map<String, dynamic> json) => LineaDeTiempo(
        idactividades: json["idactividades"],
        nombreActividad: json["nombreActividad"],
        descripcionActividad: json["descripcionActividad"],
        fecharealizacion: json["fecharealizacion"],
        fechadefinalizacion: json["fechadefinalizacion"],
        timeinicial: json["timeinicial"],
        timeFinalizacion: json["timeFinalizacion"],
        idarg: json["idarg"],
        titulo: json["titulo"],
        lugardeejecucion: json["lugardeejecucion"],
        ciudad: json["ciudad"],
        idmedios: json["idmedios"],
        nombreMedio: json["nombreMedio"]
      );

  Map<String, dynamic> toMap() => {
        "idactividades": idactividades,
        "nombreActividad": nombreActividad,
        "descripcionActividad": descripcionActividad,
        "fecharealizacion": fecharealizacion,
        "fechadefinalizacion": fechadefinalizacion,
        "timeinicial": timeinicial,
        "timeFinalizacion": timeFinalizacion,
        "idarg": idarg,
        "titulo": titulo,
        "lugardeejecucion": lugardeejecucion,
        "ciudad": ciudad,
        "idmedios": idmedios,
        "nombreMedio": nombreMedio,
      };

  @override
  String toString() {
    return 'Line de tiempo: $idactividades $nombreActividad';
  }
}
