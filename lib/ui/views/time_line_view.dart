import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:control_actividades/providers/provider.dart';
import '../../Models/http/lineaDeTiempo.dart';
// ignore: use_key_in_widget_constructors
class TimeLineView extends StatefulWidget {
  @override
  TimeLineState createState() => TimeLineState();
}

class TimeLineState extends State<TimeLineView> with TickerProviderStateMixin {
  int index = 0;
  String? selectedOptionArg;
  LineaDeTiempo? lineaDeTimepo;
  @override
  Widget build(BuildContext context) {
    final timeline = Provider.of<LineaDeTiempoProvider>(context);
    final dataLineaTiempo = timeline.lineaDeTiempo;
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(30),
              child: FooterWiget(
                label: 'Seleccionar un Arg',
                child: DropdownButtonFormField<String>(
                        value: selectedOptionArg,
                        hint: const Text('Selecciona una opcion'),
                        onChanged: (String? newValue) {
                                      setState(() {
                                        selectedOptionArg = newValue;
                                        if (selectedOptionArg != null) {
                                          lineaDeTimepo = dataLineaTiempo.firstWhere((e) => e.idarg == int.parse(newValue!));
                                        }
                                      });
                                    },
                        items: dataArg.map((item) {
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),

                  ),
                ),  
            ),
            const SizedBox(height: 20),
            if (lineaDeTimepo != null) 
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(lineaDeTimepo!.nombreActividad, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 20),
                            Text(lineaDeTimepo!.descripcionActividad),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Text('Titulo Arg: ${lineaDeTimepo!.titulo}'),
                                const SizedBox(width: 16),
                                Text('medio: ${lineaDeTimepo!.nombreMedio}')
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class FooterWiget extends StatelessWidget {
  final String label;
  final Widget child;

  const FooterWiget({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        child
      ],
    );
  }
}
