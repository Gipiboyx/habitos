import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habitos/widgets/indicator.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String? user = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();

    print(user);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.3,
              child: Card(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Habito 1"),
                          AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections()),
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
            ),
            AspectRatio(
              aspectRatio: 1.3,
              child: Card(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: showingSections()),
                        ),
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
                          text: 'Validads',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        /*sIndicator(
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
            ),
          ],
        ),
      ),
    );
  }

  double _noValidasCount = 0.0;
  double _evidenciasNoEntregadasCount = 0.0;
  double _diasHabito = 0.0;
  double _validasCount = 0.0;
  List<String> _habitosAsignados = [];
  List<PieChartSectionData> showingSections() {
    String? user = FirebaseAuth.instance.currentUser!.email;
    //int nHabitosValiados = 0;
    double noValidasCount1 = 0.0;
    double evidenciasEntregadas = 0.0;
    double validasCount = 0.0;
    FirebaseFirestore.instance
        .collection("Habitos_Asignados")
        .where('Correo', isEqualTo: user)
        .get()
        .then((value) {
      for (int i = 0; i < value.size; i++) {
        _habitosAsignados.add(value.docs[i].get('Nombre'));
      }
      FirebaseFirestore.instance
          .collection("Evidencias")
          .where('Correo', isEqualTo: user)
          .where('Nombre_habito', isEqualTo: _habitosAsignados[0])
          .get()
          .then((value) {
        for (int i = 0; i < value.size; i++) {
          evidenciasEntregadas++;
        }
        FirebaseFirestore.instance
            .collection("Habitos_Asignados")
            .where('Correo', isEqualTo: user)
            .where('Nombre', isEqualTo: _habitosAsignados[0])
            .get()
            .then((value) {
          _diasHabito = double.parse(value.docs[0].get('Dias'));
          _evidenciasNoEntregadasCount = _diasHabito - evidenciasEntregadas;
          if (mounted) {
            setState(() {});
          }
        });
      });
    });

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 60.0;
      switch (i) {
        case 0:
          FirebaseFirestore.instance
              .collection("Evidencias")
              .where('Correo', isEqualTo: user)
              .where('Estatus', isEqualTo: "No Valido")
              .get()
              .then((value) {
            for (int i = 0; i < value.size; i++) {
              noValidasCount1++;
            }
            _noValidasCount = noValidasCount1;
          });
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _noValidasCount,
            title: 'No Validadas',
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
            title: 'No Entregadas',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          );
        case 2:
          FirebaseFirestore.instance
              .collection("Evidencias")
              .where('Correo', isEqualTo: user)
              .where('Estatus', isEqualTo: "Valido")
              .get()
              .then((value) {
            for (int i = 0; i < value.size; i++) {
              validasCount++;
            }
            _validasCount = validasCount;
          });
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: _validasCount,
            title: 'Validadas',
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
