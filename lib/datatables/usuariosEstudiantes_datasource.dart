import 'package:control_actividades/Models/http/UsuariosEstudiantes.dart';
import 'package:control_actividades/ui/views/estudiantesNotasTabla_view.dart';
import 'package:flutter/material.dart';

class UsuariosEstudiantesDTS extends DataTableSource {
  final List<UsuariosEstudiantes> estudiantes;
  final BuildContext context;

  UsuariosEstudiantesDTS(this.estudiantes, this.context);

  @override
  DataRow getRow(int index) {
    final estudiante = estudiantes[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(estudiante.nombreUsuario + estudiante.apellidoUsuario)),
      DataCell(Text(estudiante.nombreGrupo)),
      DataCell(Text(estudiante.nombreSede)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return EstudianteNotasView(id: estudiante.idUsuario.toString());
                  }
                ));
              },
              icon: const Icon(Icons.edit_outlined)),
          // IconButton(
          //     onPressed: () {
          //       final dialog = AlertDialog(
          //         title: const Text('¿Está seguro de borrarlo?'),
          //         content: Text(
          //             'Borrar definitivamente ${estudiante.nombreUsuario} ${estudiante.apellidoUsuario}?'),
          //         actions: [
          //           TextButton(
          //             child: const Text('No'),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           TextButton(
          //             child: const Text('Si, borrar'),
          //             onPressed: () async {
          //               Provider.of<UsersProvider>(context, listen: false)
          //                   .deleteUser(estudiante.idUsuario);
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //         ],
          //       );

          //       showDialog(context: context, builder: (_) => dialog);
          //     },
          //     icon: Icon(Icons.delete_outline,
          //         color: Colors.red.withOpacity(0.8)))
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => estudiantes.length;

  @override
  int get selectedRowCount => 0;
}
