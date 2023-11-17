import 'package:control_actividades/Models/http/actividadesArg.dart';
import 'package:control_actividades/providers/actividadesArg_provider.dart';
import 'package:control_actividades/ui/views/activities_arg_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ActividadesArgDTS extends DataTableSource {
  final List<ActividadesArg> actividadargs;
  final BuildContext context;

  ActividadesArgDTS(this.actividadargs, this.context);

  @override
  DataRow getRow(int index) {
    final activitiesArg = actividadargs[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(activitiesArg.nombre)),
      DataCell(Text(activitiesArg.descripcion)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ActivitiesArgView(actividades: activitiesArg);
                  }
                ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${activitiesArg.nombre}?'),
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Si, borrar'),
                      onPressed: () async {
                        Provider.of<ActividadesArgProvider>(context, listen: false)
                            .deleteActividadesArg(activitiesArg.idactividades);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );

                showDialog(context: context, builder: (_) => dialog);
              },
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)))
        ],
      )),
    ]);
  }

  @override
  // implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // implement rowCount
  int get rowCount => actividadargs.length;

  @override
  // implement selectedRowCount
  int get selectedRowCount => 0;
}
