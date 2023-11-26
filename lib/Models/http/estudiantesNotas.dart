import 'dart:convert';

List<EstudianteNotas> welcomeFromJson(String str) => List<EstudianteNotas>.from(json.decode(str).map((x) => EstudianteNotas.fromJson(x)));

String welcomeToJson(List<EstudianteNotas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstudianteNotas {
    int idUsuario;
    String nombreUsuario;
    String apellidoUsuario;
    String tipoUsuario;
    int idGrupo;
    String nombreGrupo;
    int idArg;
    String tituloArg;
    String nombreSede;
    int idNota;
    int idActividad;
    double nota;
    DateTime fechaCalificacion;
    String nombreActividad;

    EstudianteNotas({
        required this.idUsuario,
        required this.nombreUsuario,
        required this.apellidoUsuario,
        required this.tipoUsuario,
        required this.idGrupo,
        required this.nombreGrupo,
        required this.idArg,
        required this.tituloArg,
        required this.nombreSede,
        required this.idNota,
        required this.idActividad,
        required this.nota,
        required this.fechaCalificacion,
        required this.nombreActividad,
    });

    factory EstudianteNotas.fromJson(Map<String, dynamic> json) => EstudianteNotas(
        idUsuario: json["idUsuario"],
        nombreUsuario: json["nombreUsuario"],
        apellidoUsuario: json["apellidoUsuario"],
        tipoUsuario: json["tipoUsuario"],
        idGrupo: json["idGrupo"],
        nombreGrupo: json["nombreGrupo"],
        idArg: json["idARG"],
        tituloArg: json["tituloARG"],
        nombreSede: json["nombreSede"],
        idNota: json["idNota"],
        idActividad: json["idActividad"],
        nota: json["nota"]?.toDouble(),
        fechaCalificacion: DateTime.parse(json["fechaCalificacion"]),
        nombreActividad: json["nombreActividad"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "nombreUsuario": nombreUsuario,
        "apellidoUsuario": apellidoUsuario,
        "tipoUsuario": tipoUsuario,
        "idGrupo": idGrupo,
        "nombreGrupo": nombreGrupo,
        "idARG": idArg,
        "tituloARG": tituloArg,
        "nombreSede": nombreSede,
        "idNota": idNota,
        "idActividad": idActividad,
        "nota": nota,
        "fechaCalificacion": fechaCalificacion.toIso8601String(),
        "nombreActividad": nombreActividad,
    };
}
