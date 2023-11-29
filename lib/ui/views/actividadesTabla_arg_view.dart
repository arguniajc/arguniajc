import 'package:control_actividades/datatables/atividades_arg_datasource.dart';
import 'package:control_actividades/providers/InfArg_provider.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:control_actividades/ui/views/activities_arg_view.dart';
import 'package:control_actividades/ui/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/actividadesArg_provider.dart';

class ActividadesArgView extends StatefulWidget {
  const ActividadesArgView({Key? key}) : super(key: key);

  @override
  _ActividadesArgViewState createState() => _ActividadesArgViewState();
}

class _ActividadesArgViewState extends State<ActividadesArgView> {
  String? selectedOptionArg;
  int idArg = 0;
  void updateState() {
    setState(() {
      // Update the state variables here
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
    final user = Provider.of<AuthProvider>(context).usuario!;
    final actividadArgProvider = Provider.of<ActividadesArgProvider>(context);
    final actividadAgrsDataSource = ActividadesArgDTS(
        selectedOptionArg != null && user.idTipoUsuario == 5
            ? actividadArgProvider.activitiesArgs
                .where(
                    (element) => element.idArg == int.parse(selectedOptionArg!))
                .toList()
            : selectedOptionArg != null
                ? actividadArgProvider.activitiesArgs
                        .where((element) => element.tokenUser == user.token)
                        .toList() ??
                    []
                : [],
        selectedOptionArg ?? '',
        context);
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
                    label: const Text('Nombre actividad'),
                    onSort: (colIndex, _) {
                      actividadArgProvider.sortColumnIndex = colIndex;
                      actividadArgProvider
                          .sort((actividad) => actividad.nombre);
                    }),
                DataColumn(
                    label: const Text('Descripción actividad'),
                    onSort: (colIndex, _) {
                      actividadArgProvider.sortColumnIndex = colIndex;
                      actividadArgProvider
                          .sort((actividad) => actividad.descripcion);
                    }),
                const DataColumn(label: Text('Acción'))
              ],
              header: Row(
                children: [
                  const Flexible(
                      child: Text(
                    'Lista de actividades del ARG:',
                    maxLines: 2,
                  )),
                  const SizedBox(width: 20),
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      value: selectedOptionArg,
                      hint: const Text('Selecciona un ARG'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOptionArg = newValue;
                          if (selectedOptionArg != null) {
                            idArg = int.parse(selectedOptionArg!);
                          }
                        });
                      },
                      items: dataArg.where((element) => element.tokenUser == user.token).map((item) {
                        return DropdownMenuItem<String>(
                          value: item.idarg.toString(),
                          child: Text(item.titulo),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              source: actividadAgrsDataSource,
              actions: [
                CustomInconButton(
                    onPressed: () {
                      if (selectedOptionArg != null) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ActivitiesArgView(
                              selectedOptionArg: selectedOptionArg);
                        }));
                      } else {
                        NotificationsService.showSnackbarError(
                            'Seleccione un arg para poder crear una actividad');
                      }
                    },
                    text: 'Crear',
                    icon: Icons.add_outlined)
              ])
        ],
      ),
    );
  }
}
