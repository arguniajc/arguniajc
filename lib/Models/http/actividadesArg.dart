import 'dart:convert';

ActividadesArg actividadesArgFromJson(String str) => ActividadesArg.fromJson(json.decode(str));

String actividadesArgToJson(ActividadesArg data) => json.encode(data.toJson());

class ActividadesArg {
    int idactividades;
    String nombre;
    String descripcion;
    int idMedios;
    String timeinicial;
    String timeFinalizacion;
    int idArg;
    String tokenUser;
    String response;
    List<ActividadesGrupo> actividadesGrupos;
    String nombreGrupo;
    String correoProfesor;
    String nombreArg;

    ActividadesArg({
        required this.idactividades,
        required this.nombre,
        required this.descripcion,
        required this.idMedios,
        required this.timeinicial,
        required this.timeFinalizacion,
        required this.idArg,
        required this.tokenUser,
        required this.response,
        required this.actividadesGrupos,
        required this.nombreGrupo,
        required this.correoProfesor,
        required this.nombreArg,
    });

    factory ActividadesArg.fromJson(Map<String, dynamic> json) => ActividadesArg(
        idactividades: json["idactividades"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        idMedios: json["idMedios"],
        timeinicial: json["timeinicial"],
        timeFinalizacion: json["timeFinalizacion"],
        idArg: json["idArg"],
        tokenUser: json["tokenUser"],
        response: json["response"],
        actividadesGrupos: List<ActividadesGrupo>.from(json["actividadesGrupos"].map((x) => ActividadesGrupo.fromJson(x))),
        nombreGrupo: json["nombre_grupo"],
        correoProfesor: json["correo_profesor"],
        nombreArg: json["nombre_arg"],
    );

    Map<String, dynamic> toJson() => {
        "idactividades": idactividades,
        "nombre": nombre,
        "descripcion": descripcion,
        "idMedios": idMedios,
        "timeinicial": timeinicial,
        "timeFinalizacion": timeFinalizacion,
        "idArg": idArg,
        "tokenUser": tokenUser,
        "response": response,
        "actividadesGrupos": List<dynamic>.from(actividadesGrupos.map((x) => x)),
        "nombre_grupo": nombreGrupo,
        "correo_profesor": correoProfesor,
        "nombre_arg": nombreArg,
    };
}

class ActividadesGrupo {
    int idactividadesGrupos;
    int idactividades;
    int idGrupos;
    String fecharealizacion;
    String fechadefinalizacion;
    String response;

    ActividadesGrupo({
        required this.idactividadesGrupos,
        required this.idactividades,
        required this.idGrupos,
        required this.fecharealizacion,
        required this.fechadefinalizacion,
        required this.response,
    });

    factory ActividadesGrupo.fromJson(Map<String, dynamic> json) => ActividadesGrupo(
        idactividadesGrupos: json["idactividadesGrupos"],
        idactividades: json["idactividades"],
        idGrupos: json["idGrupos"],
        fecharealizacion: json["fecharealizacion"],
        fechadefinalizacion: json["fechadefinalizacion"],
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "idactividadesGrupos": idactividadesGrupos,
        "idactividades": idactividades,
        "idGrupos": idGrupos,
        "fecharealizacion": fecharealizacion,
        "fechadefinalizacion": fechadefinalizacion,
        "response": response,
    };
}
