import 'package:control_actividades/ui/modals/lineaDeTiempo_modal.dart';
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
  String? selectedOptionGrupo;
  List<LineaDeTiempo> lineaDeTimepo = [];
  List<LineaDeTiempo> dataLineaTiempo = [];
  @override
  void initState() {
    super.initState();
    final timeline = Provider.of<LineaDeTiempoProvider>(context, listen: false);
    dataLineaTiempo = timeline.lineaDeTiempo;
  }

  @override
  void dispose() {
    dataLineaTiempo = [];
    Provider.of<LineaDeTiempoProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = Provider.of<InfArgProvider>(context);
    final dataArg = arg.args;
    final grupos = Provider.of<GruposProvider>(context);
    final datagrupos = grupos.gruposArgs;
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Expanded(
                      child: FooterWiget(
                            label: 'Seleccionar un ARG',
                            child: DropdownButtonFormField<String>(
                                    value: selectedOptionArg,
                                    hint: const Text('Selecciona una opción'),
                                    onChanged: (String? newValue) {
                                                  setState(() {
                                                    lineaDeTimepo = [];
                                                    selectedOptionArg = newValue;
                                                    if (selectedOptionArg != null && selectedOptionGrupo != null) {
                                                      if (dataLineaTiempo.isNotEmpty) {
                                                        lineaDeTimepo = dataLineaTiempo.where((e) => e.idarg == int.parse(selectedOptionArg!) && e.idgrupos == int.parse(selectedOptionGrupo!)).toList();
                                                        lineaDeTimepo.sort(((a, b) => a.fecharealizacion.compareTo(b.fecharealizacion)));
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
                    )
                  )
                ), 
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Expanded(
                      child: FooterWiget(
                          label: 'Seleccionar un grupo',
                          child: DropdownButtonFormField<String>(
                                value: selectedOptionGrupo,
                                hint: const Text('Selecciona una opción'),
                                onChanged: (String? newValue) {
                                              setState(() {
                                                lineaDeTimepo = [];
                                                selectedOptionGrupo = newValue;
                                                if (selectedOptionArg != null && selectedOptionGrupo != null) {
                                                  if (dataLineaTiempo.isNotEmpty) {
                                                    lineaDeTimepo = dataLineaTiempo.where((e) => e.idarg == int.parse(selectedOptionArg!) && e.idgrupos == int.parse(selectedOptionGrupo!)).toList();
                                                    lineaDeTimepo.sort(((a, b) => a.fecharealizacion.compareTo(b.fecharealizacion)));
                                                  }
                                                }
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
                  )
                ),
                const SizedBox(height: 10),
                if (lineaDeTimepo.isNotEmpty) 
                  Expanded(
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
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (_) => LineaDeTiempoModal(
                                          idActividad: lineaDeTimepo[index].idactividades,
                                          idgrupo: lineaDeTimepo[index].idgrupos,
                                          titulo: lineaDeTimepo[index].nombreActividad,
                                          fechaRealizacion: lineaDeTimepo[index].fecharealizacion,
                                          fechaDeFinalizacion: lineaDeTimepo[index].fechadefinalizacion,
                                          tiempoInicial: lineaDeTimepo[index].timeinicial,
                                          tiempoFinal: lineaDeTimepo[index].timeFinalizacion,
                                        ));
                                      setState(() {
                                        lineaDeTimepo = dataLineaTiempo.where((e) => e.idarg == int.parse(selectedOptionArg!) && e.idgrupos == int.parse(selectedOptionGrupo!)).toList();
                                        lineaDeTimepo.sort(((a, b) => a.fecharealizacion.compareTo(b.fecharealizacion)));
                                      });
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Descripcion: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                Expanded(child: Text(lineaDeTimepo[index].descripcionActividad))
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
