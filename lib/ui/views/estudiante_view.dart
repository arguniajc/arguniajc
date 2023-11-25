import 'package:control_actividades/providers/GruposArg_provider.dart';
import 'package:control_actividades/providers/SedeArg_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../inputs/custom_inputs.dart';


import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
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
          Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const ListTile(
                    title: Row(
                      children:  [
                        Expanded(child: Text('Documento')),
                        Expanded(child: Text('Nombre')),
                        Expanded(child: Text('Apellido')),
                        Expanded(child: Text('Action')), // Nueva columna
                      ],
                    ),
                  ),
                  const Divider(height: 0, thickness: 1, color: Colors.grey),
                  _buildStudentList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir la lista de estudiantes con acciones (dummy data)
  Widget _buildStudentList() {
    // Datos de ejemplo, reemplaza con tu lógica
    return Column(
      children: [
        // Estudiante 1
        Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(child: Text('123')),
                  Expanded(child: Text('John')),
                  Expanded(child: Text('Doe')),
                  // Nueva columna con iconos de acción
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit), // Icono de editar
                          onPressed: () {
                            // Lógica para editar este estudiante
                            // Por ejemplo, abrir un diálogo para editar
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete), // Icono de eliminar
                          onPressed: () {
                            // Lógica para eliminar este estudiante
                            // Por ejemplo, mostrar un diálogo de confirmación
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0, thickness: 1, color: Colors.grey), // Línea separadora
          ],
        ),
        // Estudiante 2 (puedes añadir más)
        Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(child: Text('456')),
                  Expanded(child: Text('Jane')),
                  Expanded(child: Text('Smith')),
                  // Nueva columna con iconos de acción
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit), // Icono de editar
                          onPressed: () {
                            // Lógica para editar este estudiante
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete), // Icono de eliminar
                          onPressed: () {
                            // Lógica para eliminar este estudiante
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0, thickness: 1, color: Colors.grey), // Línea separadora
          ],
        ),
        // Puedes añadir más elementos ListTile con líneas separadoras para cada estudiante
      ],
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
