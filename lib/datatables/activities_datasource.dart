import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/modals/user_modal.dart';

class ActivitiesDTS extends DataTableSource {
  final List<Usuario> usuarios;
  final BuildContext context;

  ActivitiesDTS(this.usuarios, this.context);

  @override
  DataRow getRow(int index) {
    final user = usuarios[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(user.documento.toString())),
      DataCell(Text(user.nombre)),
      DataCell(Text(user.apellido)),
      DataCell(Text(user.email)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => UserModal(
                          user: user,
                        ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${user.nombre} ${user.apellido}?'),
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
                            .deleteUser(user.idusuario);
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
  int get rowCount => usuarios.length;

  @override
  int get selectedRowCount => 0;
}
