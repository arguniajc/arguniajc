import 'package:control_actividades/Models/http/TypeUser.dart';
import 'package:control_actividades/providers/typeUsers_provider.dart';
import 'package:control_actividades/ui/modals/Typeuser_modal%20copy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoUsuarioDTS extends DataTableSource {
  final List<TypeUser> tipoUsuarios;
  final BuildContext context;

  TipoUsuarioDTS(this.tipoUsuarios, this.context);

  @override
  DataRow getRow(int index) {
    final tipo = tipoUsuarios[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(tipo.descripcion)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => TypeUserModal(
                          tipo: tipo,
                        ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${tipo.descripcion}?'),
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
                        Provider.of<TypeUsersProvider>(context, listen: false)
                            .deleteUser(tipo.idTypeUser);
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
  int get rowCount => tipoUsuarios.length;

  @override
  int get selectedRowCount => 0;
}
