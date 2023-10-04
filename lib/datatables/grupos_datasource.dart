import 'package:control_actividades/Models/http/GruposArg.dart';
import 'package:control_actividades/providers/provider.dart';
import 'package:control_actividades/providers/users_provider.dart';
import 'package:control_actividades/ui/views/Grupos_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GruposDTS extends DataTableSource {
  final List<GruposArg> grupos;
  final BuildContext context;

  GruposDTS(this.grupos, this.context);

  @override
  DataRow getRow(int index) {
    final gruposArg = grupos[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(gruposArg.nombreGrupo)),
      DataCell(Text(gruposArg.nombreSede)),
      DataCell(Text(gruposArg.titulo)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return GruposView(grupos: gruposArg);
                  }
                ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${gruposArg.nombreGrupo}?'),
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
                        Provider.of<GruposProvider>(context, listen: false)
                            .deleteGrupos(gruposArg.idArg);
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
  int get rowCount => grupos.length;

  @override
  int get selectedRowCount => 0;
}
