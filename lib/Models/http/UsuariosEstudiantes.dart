import 'dart:convert';

class UsuariosEstudiantes {
  int idUsuario;
  String nombreUsuario;
  String apellidoUsuario;
  String tipoUsuario;
  int idGrupo;
  String nombreGrupo;
  int idARG;
  String tituloARG;
  int idSede;
  String nombreSede;

  UsuariosEstudiantes({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.apellidoUsuario,
    required this.tipoUsuario,
    required this.idGrupo,
    required this.nombreGrupo,
    required this.idARG,
    required this.tituloARG,
    required this.idSede,
    required this.nombreSede
  });

  factory UsuariosEstudiantes.fromJson(String str) => UsuariosEstudiantes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuariosEstudiantes.fromMap(Map<String, dynamic> json) => UsuariosEstudiantes(
        idUsuario: json["idUsuario"],
        nombreUsuario: json["nombreUsuario"],
        apellidoUsuario: json["apellidoUsuario"],
        tipoUsuario: json["tipoUsuario"],
        idGrupo: json["idGrupo"],
        nombreGrupo: json["nombreGrupo"],
        idARG: json["idARG"],
        tituloARG: json["tituloARG"],
        idSede: json["idSede"],
        nombreSede: json["nombreSede"]
      );

  Map<String, dynamic> toMap() => {
        "idUsuario": idUsuario,
        "nombreUsuario": nombreUsuario,
        "apellidoUsuario": apellidoUsuario,
        "tipoUsuario": tipoUsuario,
        "idGrupo": idGrupo,
        "nombreGrupo": nombreGrupo,
        "idARG": idARG,
        "tituloARG": tituloARG,
        "idSede": idSede,
        "nombreSede": nombreSede,
      };

  @override
  String toString() {
    return 'Estudiante: $nombreUsuario $apellidoUsuario';
  }
}
