import 'package:control_actividades/Models/http/estudiantesnotas.dart';
import 'package:control_actividades/datatables/estudiantesNotas_datasource.dart';
import 'package:control_actividades/providers/estudiantesNotas_provider.dart';
import 'package:control_actividades/services/navigation_service.dart';
import 'package:control_actividades/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudianteNotasView extends StatefulWidget {
  final String id;
  const EstudianteNotasView({Key? key, required this.id}) : super(key: key);

  @override
  EstudianteNotasViewState createState() => EstudianteNotasViewState();
}

class EstudianteNotasViewState extends State<EstudianteNotasView> {
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  void initState() {
    super.initState();
    
    
    Provider.of<EstudiantesNotasProvider>(context, listen: false).getEstudiantesNotas(widget.id);
    // estudiantesProviders.getEstudiantesNotas(widget.id).then((userDB) {
    //   if (userDB.isNotEmpty) {
    //     setState(() {
    //       notas = userDB;
    //     });
    //   } else {
    //     NavigationService.replaceTo('/dashboard/estudiantes');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final notas = Provider.of<EstudiantesNotasProvider>(context).estudiantesNotas;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Notas', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
              columns: const [
                DataColumn(
                    label: Text('Nombre actividad')),
                DataColumn(
                    label: Text('Nombre del grupo')),
                DataColumn(
                    label: Text('Fecha de calificacion')),
                DataColumn(
                    label: Text('Nota')),
                DataColumn(label: Text('Acción'))
              ],
              source: EstudiantesNotasDTS(notas,context),
              onRowsPerPageChanged: (value) {
              setState(() {
                _rowPerPage = value ?? 10;
              });
              },
              rowsPerPage: _rowPerPage
              )
        ],
      ),
    );
  }
}
