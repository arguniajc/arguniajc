import 'package:control_actividades/ui/modals/lineaDeTiempo_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:control_actividades/providers/provider.dart';
import '../../Models/http/lineaDeTiempo.dart';
import 'package:control_actividades/ui/views/activities_arg_view.dart';
// ignore: use_key_in_widget_constructors
class TimeLineView extends StatefulWidget {
  @override
  TimeLineState createState() => TimeLineState();
}

class TimeLineState extends State<TimeLineView> with TickerProviderStateMixin {
  int index = 0;
  String? selectedOptionArg;
  List<LineaDeTiempo> lineaDeTimepo = [];
  @override
  Widget build(BuildContext context) {
    final timeline = Provider.of<LineaDeTiempoProvider>(context);
    final dataLineaTiempo = timeline.lineaDeTiempo;
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      FooterWiget(
                            label: 'Seleccionar un Arg',
                            child: DropdownButtonFormField<String>(
                                    value: selectedOptionArg,
                                    hint: const Text('Selecciona una opcion'),
                                    onChanged: (String? newValue) {
                                                  setState(() {
                                                    lineaDeTimepo = [];
                                                    selectedOptionArg = newValue;
                                                    if (selectedOptionArg != null) {
                                                      final data = dataLineaTiempo.where((e) => e.idarg == int.parse(newValue!));
                                                      if (data.isNotEmpty) {
                                                        lineaDeTimepo.addAll(data);
                                                      }
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
                      
                      ],
                    ),
                  )
                ), 
                const SizedBox(height: 10),
                if (lineaDeTimepo.isNotEmpty) 
                  Flexible(
                    child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: lineaDeTimepo.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  child:  InkWell(
                                    splashColor: Colors.grey,
                                    highlightColor: Colors.grey,
                                    onTap: () => {
                                      showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (_) => LineaDeTiempoModal(
                                            idActividad: lineaDeTimepo[index].idactividades,
                                            titulo: lineaDeTimepo[index].nombreActividad,
                                            fechaRealizacion: lineaDeTimepo[index].fecharealizacion,
                                            fechaDeFinalizacion: lineaDeTimepo[index].fechadefinalizacion,
                                            tiempoInicial: lineaDeTimepo[index].timeinicial,
                                            tiempoFinal: lineaDeTimepo[index].timeFinalizacion,
                                          ))
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    customBorder: const StadiumBorder(),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text(lineaDeTimepo[index].nombreActividad, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Text('Fecha de realizacion: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text(lineaDeTimepo[index].fecharealizacion.substring(0,10)),
                                                    ],
                                                  )
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      const Text('Fecha de finalizacion: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text(lineaDeTimepo[index].fechadefinalizacion.substring(0,10)),
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Text('Duracion inicial: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text(lineaDeTimepo[index].timeinicial),
                                                    ],
                                                  )
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      const Text('Duracion final: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text(lineaDeTimepo[index].timeFinalizacion),
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              children: [
                                                const Text('Titulo Arg: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                Text(lineaDeTimepo[index].titulo),
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Text('Medio: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text(lineaDeTimepo[index].nombreMedio)
                                                    ],
                                                  )
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      const Text('Lugar de ejecucion: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text(lineaDeTimepo[index].lugardeejecucion),
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              children: [
                                                const Text('Descripcion: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                Text(lineaDeTimepo[index].descripcionActividad),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                )
                              );
                            },
                          ),
                  )
              ],
            )
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
