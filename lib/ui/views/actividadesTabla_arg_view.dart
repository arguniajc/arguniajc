import 'package:control_actividades/datatables/atividades_arg_datasource.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/views/activities_arg_view.dart';
import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/actividadesArg_provider.dart';

class ActividadesArgView extends StatelessWidget {
  const ActividadesArgView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;
    final actividadArgProvider = Provider.of<ActividadesArgProvider>(context);

    final actividadAgrsDataSource = ActividadesArgDTS(user.idTipoUsuario == 5 ? actividadArgProvider.activitiesArgs : actividadArgProvider.activitiesArgs.where((element) => element.tokenUser == user.token).toList() ?? [], context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Actividades', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              sortAscending: actividadArgProvider.ascending,
              sortColumnIndex: actividadArgProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Nombre'),
                    onSort: (colIndex, _) {
                      actividadArgProvider.sortColumnIndex = colIndex;
                      actividadArgProvider.sort((actividad) => actividad.nombre);
                    }),
                DataColumn(
                    label: const Text('Descripción'),
                    onSort: (colIndex, _) {
                      actividadArgProvider.sortColumnIndex = colIndex;
                      actividadArgProvider.sort((actividad) => actividad.descripcion);
                    }),
                const DataColumn(label: Text('Acción'))
              ],
              header: const Text(
                'Lista de actividades',
                maxLines: 2,
              ),
              source: actividadAgrsDataSource,
              actions: [
                CustomInconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const ActivitiesArgView();
                      }
                    ));
                  },
                  text: 'Crear',
                  icon: Icons.add_outlined)
              ])
        ],
      ),
    );
  }
}
