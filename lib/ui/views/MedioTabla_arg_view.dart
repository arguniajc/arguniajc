import 'package:control_actividades/datatables/medio_datasource.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/views/medio_view.dart';
import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/MediosArg_provider.dart';

class MedioTablaArgView extends StatelessWidget {
  const MedioTablaArgView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;
    final medioProvider = Provider.of<MediosProvider>(context);

    final medioDataSource = MedioDTS(user.idTipoUsuario == 5 ? medioProvider.mediosArgs : medioProvider.mediosArgs.where((element) => element.tokenUser == user.token).toList() ?? [], context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Medios', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              sortAscending: medioProvider.ascending,
              sortColumnIndex: medioProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Nombre'),
                    onSort: (colIndex, _) {
                      medioProvider.sortColumnIndex = colIndex;
                      medioProvider.sort((medio) => medio.nombre);
                    }),
                DataColumn(
                    label: const Text('Tipo'),
                    onSort: (colIndex, _) {
                      medioProvider.sortColumnIndex = colIndex;
                      medioProvider.sort((medio) => medio.tipoMedio);
                    }),
                const DataColumn(label: Text('Action'))
              ],
              header: const Text(
                'Lista de Medios',
                maxLines: 2,
              ),
              source: medioDataSource,
              actions: [
                CustomInconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MediosView();
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
