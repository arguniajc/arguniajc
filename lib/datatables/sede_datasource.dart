import 'package:control_actividades/Models/http/SedeArg.dart';
import 'package:control_actividades/providers/provider.dart';
import 'package:control_actividades/providers/users_provider.dart';
import 'package:control_actividades/ui/views/sede_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SedeDTS extends DataTableSource {
  final List<SedeArg> sede;
  final BuildContext context;

  SedeDTS(this.sede, this.context);

  @override
  DataRow getRow(int index) {
    final sedes = sede[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(sedes.nombre)),
      DataCell(Text(sedes.tipoSede)),
      DataCell(Text(sedes.descripcion)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SedeView(sede: sedes);
                  }
                ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${sedes.nombre}?'),
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Si, borrar'),
                      onPressed: () async {
                        Provider.of<SedeProvider>(context, listen: false)
                            .deleteSede(sedes.idUniversidad);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );

                showDialog(context: context, builder: (_) => dialog);
              },
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)))
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => sede.length;

  @override
  int get selectedRowCount => 0;
}
