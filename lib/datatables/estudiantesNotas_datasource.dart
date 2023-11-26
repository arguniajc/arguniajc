import 'package:control_actividades/Models/http/estudiantesnotas.dart';
import 'package:control_actividades/ui/modals/nota_modal.dart';
import 'package:flutter/material.dart';

class EstudiantesNotasDTS extends DataTableSource {
  final List<EstudianteNotas> notas;
  final BuildContext context;

  EstudiantesNotasDTS(this.notas, this.context);

  @override
  DataRow getRow(int index) {
    final nota = notas[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(nota.nombreActividad)),
      DataCell(Text(nota.nombreGrupo)),
      DataCell(Text(nota.fechaCalificacion.toString().substring(0,10))),
      DataCell(Text(nota.nota.toString())),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => NotasModal(nota: nota));
              },
              icon: const Icon(Icons.edit_outlined))
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => notas.length;

  @override
  int get selectedRowCount => 0;
}
