import 'package:flutter/material.dart';
import '../inputs/custom_inputs.dart';


import 'package:flutter/material.dart';

class EstudiantesView extends StatefulWidget {
  const EstudiantesView({Key? key}) : super(key: key);

  @override
  _EstudiantesViewState createState() => _EstudiantesViewState();
}

class _EstudiantesViewState extends State<EstudiantesView> {
  @override
  Widget build(BuildContext context) {
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
                            label: "Universidad",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                hint: 'Ingrese el nombre de la Universidad',
                                label: 'Nombre de la Universidad',
                                icon: Icons.business,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FooterWidget(
                            label: "Grupo",
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: CustomInputs.loginInputDecoration(
                                hint: 'Ingrese el código del grupo',
                                label: 'Código Grupo',
                                icon: Icons.groups,
                              ),
                            ),
                          ),
                        ),
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
