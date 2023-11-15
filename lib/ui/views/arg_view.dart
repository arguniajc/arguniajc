import 'package:control_actividades/Models/http/auth_response.dart';
import 'package:control_actividades/datatables/arg_datasource.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/views/inf_arg.dart';
import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/InfArg_provider.dart';

class ArgView extends StatelessWidget {
  
  const ArgView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;
    final argProvider = Provider.of<InfArgProvider>(context);
    
    final agrsDataSource = ArgDTS(user.idTipoUsuario == 5 ? argProvider.args : argProvider.args.where((element) => element.tokenUser == user.token).toList() ?? [], context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Args', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              sortAscending: argProvider.ascending,
              sortColumnIndex: argProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Titulo'),
                    onSort: (colIndex, _) {
                      argProvider.sortColumnIndex = colIndex;
                      argProvider.sort((arg) => arg.titulo);
                    }),
                DataColumn(
                    label: const Text('Asignatura'),
                    onSort: (colIndex, _) {
                      argProvider.sortColumnIndex = colIndex;
                      argProvider.sort((arg) => arg.asignatura);
                    }),
                const DataColumn(label: Text('Propsito')),
                const DataColumn(label: Text('Action'))
              ],
              header: const Text(
                'Lista de args',
                maxLines: 2,
              ),
              source: agrsDataSource,
              actions: [
                CustomInconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const InfArgView();
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
