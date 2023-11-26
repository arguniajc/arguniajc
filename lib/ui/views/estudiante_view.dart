import 'package:control_actividades/datatables/usuariosEstudiantes_datasource.dart';
import 'package:control_actividades/providers/GruposArg_provider.dart';
import 'package:control_actividades/providers/SedeArg_provider.dart';
import 'package:control_actividades/providers/usuariosEstudiantes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudiantesView extends StatefulWidget {
  const EstudiantesView({Key? key}) : super(key: key);

  @override
  _EstudiantesViewState createState() => _EstudiantesViewState();
}

class _EstudiantesViewState extends State<EstudiantesView> {
  String? selectedOptionSede;
  String? selectedOptionGrupo;

  @override
  Widget build(BuildContext context) {
    final sede = Provider.of<SedeProvider>(context, listen: false);
    final datasede = sede.sedeArgs;
    final grupos = Provider.of<GruposProvider>(context);
    final datagrupos = grupos.gruposArgs;
    final estudiantesProvider = Provider.of<UsuariosEstudiantesProvider>(context, listen: false);
    final estudiantesDataSource = UsuariosEstudiantesDTS(selectedOptionGrupo != null && selectedOptionSede != null ? estudiantesProvider.usuariosEtudiantes.where((element) => element.idGrupo == int.parse(selectedOptionGrupo!) && element.idSede == int.parse(selectedOptionSede!)).toList() : [],context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
           SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(2),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.school,
                            size: 50,
                          ),
                          title: Text(
                            'Estudiantes',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                                Expanded(
                                  child: FooterWidget(
                                    label: 'Universidad',
                                    child: DropdownButtonFormField<String>(
                                          value: selectedOptionSede,
                                          hint: const Text('Selecciona una opcion'),
                                          onChanged: (String? newValue) {
                                                        setState(() {
                                                          selectedOptionSede = newValue;
                                                        });
                                                      },
                                          items: datasede.map((item) {
                                            return DropdownMenuItem<String>(
                                                  value: item.idUniversidad.toString(),
                                                  child: Text(item.nombre),
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                    
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                child: FooterWidget(
                                  label: 'Grupo',
                                  child: DropdownButtonFormField<String>(
                                        value: selectedOptionGrupo,
                                        hint: const Text('Selecciona una opcion'),
                                        onChanged: (String? newValue) {
                                                      setState(() {
                                                        selectedOptionGrupo = newValue;
                                                      });
                                                    },
                                        items: datagrupos.map((item) {
                                          return DropdownMenuItem<String>(
                                                value: item.idGrupos.toString(),
                                                child: Text(item.nombreGrupo),
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                  
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: selectedOptionGrupo != null && selectedOptionSede != null,
            child: PaginatedDataTable(
              sortAscending: estudiantesProvider.ascending,
              sortColumnIndex: estudiantesProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Nombre Usuario'),
                    onSort: (colIndex, _) {
                      estudiantesProvider.sortColumnIndex = colIndex;
                      estudiantesProvider
                          .sort((actividad) => actividad.nombreUsuario);
                    }),
                DataColumn(
                    label: const Text('Descripción Grupo'),
                    onSort: (colIndex, _) {
                      estudiantesProvider.sortColumnIndex = colIndex;
                      estudiantesProvider
                          .sort((actividad) => actividad.nombreGrupo);
                    }),
                DataColumn(
                    label: const Text('Descripción Sede'),
                    onSort: (colIndex, _) {
                      estudiantesProvider.sortColumnIndex = colIndex;
                      estudiantesProvider
                          .sort((actividad) => actividad.nombreSede);
                    }),
                const DataColumn(label: Text('Acción'))
              ],
              source: estudiantesDataSource)
          )
        ],
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  final String label;
  final Widget child;

  const FooterWidget({Key? key, required this.label, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
