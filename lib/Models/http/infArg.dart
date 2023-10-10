import 'dart:convert';

class InfArg {
  int idarg;
  String titulo;
  String observaciones;
  String areadeconocimiento;
  String asignatura;
  String modalidaddeestudio;
  String coceptos;
  String proposito;
  String sinopsis;
  String agujerodeconejo;
  String jugabilidad;
  String participantes;
  String duracionaprox;
  String entidad;
  String pais;
  String lugardeejecucion;
  int idPuppetmaster;
  int token;
  String response;

  InfArg({
    required this.idarg,
    required this.titulo,
    required this.observaciones,
    required this.areadeconocimiento,
    required this.asignatura,
    required this.modalidaddeestudio,
    required this.coceptos,
    required this.proposito,
    required this.sinopsis,
    required this.agujerodeconejo,
    required this.jugabilidad,
    required this.participantes,
    required this.duracionaprox,
    required this.entidad,
    required this.pais,
    required this.lugardeejecucion,
    required this.idPuppetmaster,
    required this.token,
    required this.response,
  });

  factory InfArg.fromJson(String str) => InfArg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfArg.fromMap(Map<String, dynamic> json) => InfArg(
        idarg: json["idarg"],
        titulo: json["titulo"],
        observaciones: json["observaciones"],
        areadeconocimiento: json["areadeconocimiento"],
        asignatura: json["asignatura"],
        modalidaddeestudio: json["modalidaddeestudio"],
        coceptos: json["coceptos"],
        proposito: json["proposito"],
        sinopsis: json["sinopsis"],
        agujerodeconejo: json["agujerodeconejo"],
        jugabilidad: json["jugabilidad"],
        participantes: json["participantes"],
        duracionaprox: json["duracionaprox"],
        entidad: json["entidad"],
        pais: json["pais"],
        lugardeejecucion: json["lugardeejecucion"],
        idPuppetmaster: json["idPuppetmaster"],
        token: json["token"],
        response: json["response"],
      );

  Map<String, dynamic> toMap() => {
        "idarg": idarg,
        "titulo": titulo,
        "observaciones": observaciones,
        "areadeconocimiento": areadeconocimiento,
        "asignatura": asignatura,
        "modalidaddeestudio": modalidaddeestudio,
        "coceptos": coceptos,
        "proposito": proposito,
        "sinopsis": sinopsis,
        "agujerodeconejo": agujerodeconejo,
        "jugabilidad": jugabilidad,
        "participantes": participantes,
        "duracionaprox": duracionaprox,
        "entidad": entidad,
        "pais": pais,
        "lugardeejecucion": lugardeejecucion,
        "idPuppetmaste": idPuppetmaster,
        "token": token,
        "response": response,
      };

  @override
  String toString() {
    return 'Arg: $titulo $pais';
  }
}
