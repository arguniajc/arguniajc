import 'package:control_actividades/Models/http/actividadesArg.dart';
import 'package:control_actividades/ui/views/activities_arg_view.dart';
import 'package:control_actividades/providers/InfArg_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ActividadesArgDTS extends DataTableSource {
  final List<ActividadesArg> actividadargs;
  final BuildContext context;

  ActividadesArgDTS(this.actividadargs, this.context);

  @override
  DataRow getRow(int index) {
    final ActivitiesArg = actividadargs[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(ActivitiesArg.nombre)),
      DataCell(Text(ActivitiesArg.descripcion)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ActivitiesArgView(actividades: ActivitiesArg);
                  }
                ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${ActivitiesArg.nombre}?'),
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
                        Provider.of<InfArgProvider>(context, listen: false)
                            .deleteArg(ActivitiesArg.idactividades);
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
