import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/modals/Typeuser_modal%20copy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../datatables/typeUser_datasource.dart';
import '../../providers/typeUsers_provider.dart';

class TypeUserView extends StatefulWidget {
  const TypeUserView({super.key});

  @override
  TypeUserViewState createState() => TypeUserViewState();
}

class TypeUserViewState extends State<TypeUserView> {
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<TypeUsersProvider>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<TypeUsersProvider>(context).typeUsers;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          Text('Tipo de usuario', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Descripción')),
              DataColumn(label: Text('Acción'))
            ],
            source: TipoUsuarioDTS(users, context),
            header: const Text(
              'Lista de Tipos de usuarios',
              maxLines: 2,
            ),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowPerPage,
            actions: [
              CustomInconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => const TypeUserModal());
                  },
                  text: 'Crear',
                  icon: Icons.add_outlined)
            ],
          )
        ]));
  }
}
