import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/modals/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../datatables/activities_datasource.dart';
import '../../providers/ativities_provider.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key});

  @override
  ActivitiesViewState createState() => ActivitiesViewState();
}

class ActivitiesViewState extends State<ActivitiesView> {
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<ActivitiesProvider>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<ActivitiesProvider>(context).users;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          Text('Medio', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('Documento')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Apelldio')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Action'))
            ],
            source: ActivitiesDTS(users, context),
            header: const Text(
              'Lista de actividades',
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
                        builder: (_) => UserModal());
                  },
                  text: 'Crear',
                  icon: Icons.add_outlined)
            ],
          )
        ]));
  }
}
