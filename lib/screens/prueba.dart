import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habitos/widgets/indicator.dart';

class Prueba extends StatefulWidget {
  Prueba({Key? key}) : super(key: key);

  @override
  State<Prueba> createState() => _PruebaState();
}

int touchedIndex = -1;
List<String> _habitosAsignados = [];

class _PruebaState extends State<Prueba> {
  String? user = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Habitos_Asignados")
        .where('Correo', isEqualTo: user)
        .get()
        .then((value) {
      List<String> aux = [];
      for (var i = 0; i < value.size; i++) {
        aux.add(value.docs[i].get("Nombre"));
      }
      _habitosAsignados = aux;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("¡No te rindas!"),
      ),
      body: ListView.builder(
          itemCount: _habitosAsignados.length,
          itemBuilder: (context, index) {
            return Column(children: [
              Card(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(_habitosAsignados[index]),
                          AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections(
                                      _habitosAsignados[index])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Indicator(
                          color: Color(0xff0293ee),
                          text: 'No Validadas',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xfff8b250),
                          text: 'No Entregadas',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xff845bef),
                          text: 'Validadas',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        /*Indicator(
                          color: Color(0xff13d38e),
                          text: 'Fourth',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 18,
                        ),*/
                      ],
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                ),
              ),
            ]);
          }),
    );
  }

  double _evidenciasNoEntregadasCount = 30.0;
  double _noValidasCount = 40.0;
  double _validasCount = 30.0;
  List<PieChartSectionData> showingSections(String habito) {
    //int nHabitosValiados = 0;

    FirebaseFirestore.instance
        .collection("Evidencias")
        .where('Correo', isEqualTo: user)
        .where('Nombre_habito', isEqualTo: habito)
        .get()
        .then((value) {
      double evidenciasEntregadas = 0.0;
      for (int i = 0; i < value.size; i++) {
        evidenciasEntregadas++;
      }
      FirebaseFirestore.instance
          .collection("Habitos_Asignados")
          .where('Correo', isEqualTo: user)
          .where('Nombre', isEqualTo: habito)
          .get()
          .then((value) {
        double _diasHabito = double.parse(value.docs[0].get('Dias'));
        _evidenciasNoEntregadasCount = _diasHabito - evidenciasEntregadas;
      });
    });
    FirebaseFirestore.instance
        .collection("Evidencias")
        .where('Correo', isEqualTo: user)
        .where('Estatus', isEqualTo: "No Valido")
        .where('Nombre_habito', isEqualTo: habito)
        .get()
        .then((value) {
      double noValidasCount = 0.0;
      for (int i = 0; i < value.size; i++) {
        noValidasCount++;
      }
      _noValidasCount = noValidasCount;
    });
    FirebaseFirestore.instance
        .collection("Evidencias")
        .where('Correo', isEqualTo: user)
        .where('Estatus', isEqualTo: "Valido")
        .where('Nombre_habito', isEqualTo: habito)
        .get()
        .then((value) {
      double validasCount = 0.0;
      for (int i = 0; i < value.size; i++) {
        validasCount++;
      }
      _validasCount = validasCount;
    });

    return List.generate(3, (i) {
      //final isTouched = i == touchedIndex;
      final fontSize = 25.0;
      final radius = 40.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _noValidasCount,
            showTitle: false,
            //title: 'No Validadas',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _evidenciasNoEntregadasCount,
            showTitle: false,
            //title: 'No Entregadas',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: _validasCount,
            showTitle: false,
            //title: 'Validadas',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          );
        default:
          throw Error();
      }
    });
  }
}
