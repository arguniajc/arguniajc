import 'package:control_actividades/datatables/user_datasource.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users_provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource = UsuerDTS(usersProvider.users, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Users', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              sortAscending: usersProvider.ascending,
              sortColumnIndex: usersProvider.sortColumnIndex,
              columns: [
                const DataColumn(label: Text('Avatar')),
                DataColumn(
                    label: const Text('Documento'),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort((user) => user.documento);
                    }),
                DataColumn(
                    label: const Text('Name'),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort((user) => user.nombre);
                    }),
                DataColumn(
                    label: const Text('Apelldio'),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort((user) => user.apellido);
                    }),
                const DataColumn(label: Text('Email')),
                const DataColumn(label: Text('Action'))
              ],
              source: usersDataSource,
              onPageChanged: (page) {})
        ],
      ),
    );
  }
}
