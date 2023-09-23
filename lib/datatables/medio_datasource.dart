import 'package:control_actividades/Models/http/MediosArg.dart';
import 'package:control_actividades/providers/users_provider.dart';
import 'package:control_actividades/ui/views/medio_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedioDTS extends DataTableSource {
  final List<MediosArg> medios;
  final BuildContext context;

  MedioDTS(this.medios, this.context);

  @override
  DataRow getRow(int index) {
    final medio = medios[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(medio.nombre)),
      DataCell(Text(medio.tipoMedio)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => MediosView(
                          medio: medio,
                        ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${medio.nombre}?'),
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
                        Provider.of<UsersProvider>(context, listen: false)
                            .deleteUser(medio.idMedios);
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
  int get rowCount => medios.length;

  @override
  int get selectedRowCount => 0;
}
