import 'package:control_actividades/datatables/sede_datasource.dart';
import 'package:control_actividades/providers/provider.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:control_actividades/ui/views/sede_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SedeTablaArgView extends StatelessWidget {
  const SedeTablaArgView({super.key});

  @override
  Widget build(BuildContext context) {
    final sedeProvider = Provider.of<SedeProvider>(context);

    final sedeDataSource = SedeDTS(sedeProvider.sedeArgs, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Sede', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              sortAscending: sedeProvider.ascending,
              sortColumnIndex: sedeProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Nombre'),
                    onSort: (colIndex, _) {
                      sedeProvider.sortColumnIndex = colIndex;
                      sedeProvider.sort((sede) => sede.nombre);
                    }),
                DataColumn(
                    label: const Text('Tipo'),
                    onSort: (colIndex, _) {
                      sedeProvider.sortColumnIndex = colIndex;
                      sedeProvider.sort((sede) => sede.tipoSede);
                    }),
                DataColumn(
                    label: const Text('Descripción'),
                    onSort: (colIndex, _) {
                      sedeProvider.sortColumnIndex = colIndex;
                      sedeProvider.sort((sede) => sede.descripcion);
                    }),
                const DataColumn(label: Text('Acción'))
              ],
              header: const Text(
                'Lista de Sede',
                maxLines: 2,
              ),
              source: sedeDataSource,
              actions: [
                CustomInconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SedeView();
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
