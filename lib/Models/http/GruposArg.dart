import 'dart:convert';

class GruposArg {
  int idGrupos;
  String nombreGrupo;
  int idArg;
  int idProfesor;
  int idSede;
  String nombreSede;
  String profesorNombre;
  String titulo;
  String respuesta;
  String tokenGrupo;
 
 
  GruposArg({
    required this.idGrupos,
    required this.nombreGrupo,
    required this.idArg,
    required this.idProfesor,
    required this.profesorNombre,
    required this.idSede,
    required this.nombreSede,
    required this.titulo,
    required this.tokenGrupo,
    required this.respuesta
  });

  factory GruposArg.fromJson(String str) => GruposArg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GruposArg.fromMap(Map<String, dynamic> json) => GruposArg(
        idGrupos: json["idGrupos"],
        nombreGrupo: json["nombreGrupo"],
        idArg: json["idArg"],
        idProfesor: json["idProfesor"],
        profesorNombre: json["profesorNombre"],
        idSede: json["idSede"],
        nombreSede: json["nombreSede"],
        titulo: json["titulo"],
        tokenGrupo: json["tokenGrupo"],
        respuesta: json["respuesta"],
      );



  Map<String, dynamic> toMap() => {
        "idGrupos": idGrupos,
        "nombreGrupo": nombreGrupo,
        "idArg": idArg,
        "profesorNombre": profesorNombre,
        "idProfesor": idProfesor,
        "idSede": idSede,
        "nombreSede": nombreSede,
        "titulo": titulo,
        "tokenGrupo": tokenGrupo,
        "respuesta": respuesta,
        
      };

  @override
  String toString() {
    return 'MediosArg: $idGrupos $nombreGrupo';
  }
}
