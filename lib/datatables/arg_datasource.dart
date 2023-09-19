import 'package:control_actividades/Models/http/infArg.dart';
import 'package:control_actividades/ui/views/inf_arg.dart';
import 'package:control_actividades/providers/InfArg_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ArgDTS extends DataTableSource {
  final List<InfArg> args;
  final BuildContext context;

  ArgDTS(this.args, this.context);

  @override
  DataRow getRow(int index) {
    final arg = args[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(arg.titulo)),
      DataCell(Text(arg.asignatura)),
      DataCell(Text(arg.proposito)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return InfArgView(arg: arg);
                  }
                ));
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      'Borrar definitivamente ${arg.titulo}?'),
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
                            .deleteArg(arg.idarg);
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
  int get rowCount => args.length;

  @override
  // implement selectedRowCount
  int get selectedRowCount => 0;
}
