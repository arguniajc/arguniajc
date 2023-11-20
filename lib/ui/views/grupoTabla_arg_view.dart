import 'package:control_actividades/datatables/Grupos_datasource.dart';
import 'package:control_actividades/providers/provider.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:control_actividades/ui/views/Grupos_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GruposTablaArgView extends StatelessWidget {
  const GruposTablaArgView({super.key});
  

  @override 
  Widget build(BuildContext context) {
    final gruposProvider = Provider.of<GruposProvider>(context);

    final gruposDataSource = GruposDTS(gruposProvider.gruposArgs, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Grupos', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              sortAscending: gruposProvider.ascending,
              sortColumnIndex: gruposProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Nombre grupo'),
                    onSort: (colIndex, _) {
                      gruposProvider.sortColumnIndex = colIndex;
                      gruposProvider.sort((grupos) => grupos.nombreGrupo);
                    }),
                DataColumn(
                    label: const Text('Nombre IE'),
                    onSort: (colIndex, _) {
                      gruposProvider.sortColumnIndex = colIndex;
                      gruposProvider.sort((grupos) => grupos.nombreSede);
                    }),
                    DataColumn(
                    label: const Text('Nombre profesor'),
                    onSort: (colIndex, _) {
                      gruposProvider.sortColumnIndex = colIndex;
                      gruposProvider.sort((grupos) => grupos.profesorNombre);
                    }),
                DataColumn(
                    label: const Text('Nombre ARG'),
                    onSort: (colIndex, _) {
                      gruposProvider.sortColumnIndex = colIndex;
                      gruposProvider.sort((grupos) => grupos.titulo);
                    }),
                const DataColumn(label: Text('Acción'))
              ],
              header: const Text(
                'Lista de Grupos',
                maxLines: 2,
              ),
              source: gruposDataSource,
              actions: [
                CustomInconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const GruposView();
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
