import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/services/navigation_service.dart';
import 'package:flutter/material.dart';

class UsuerDTS extends DataTableSource {
  final List<Usuario> usuarios;
  final BuildContext context;

  UsuerDTS(this.usuarios, this.context);

  @override
  DataRow getRow(int index) {
    final user = usuarios[index];
    final image = (user.img!.isEmpty)
        ? const Image(image: AssetImage('no-image.jpg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: user.img!, width: 35, height: 35);

    return DataRow.byIndex(index: index, cells: [
      DataCell(ClipOval(
        child: image,
      )),
      DataCell(Text(user.documento.toString())),
      DataCell(Text(user.nombre)),
      DataCell(Text(user.apellido)),
      DataCell(Text(user.email)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                NavigationService.replaceTo(
                    '/dashboard/users/${user.documento}');
              },
              icon: const Icon(Icons.edit_outlined))
        ],
      )),
    ]);
  }

  @override
  // implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // implement rowCount
  int get rowCount => usuarios.length;

  @override
  // implement selectedRowCount
  int get selectedRowCount => 0;
}
