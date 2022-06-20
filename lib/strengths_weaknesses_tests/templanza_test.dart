import 'package:flutter/material.dart';
import 'package:habitos/widgets/page_view.dart';

class TemplanzaTest extends StatefulWidget {
  const TemplanzaTest({Key? key}) : super(key: key);

  @override
  State<TemplanzaTest> createState() => _TemplanzaTestState();
}

class _TemplanzaTestState extends State<TemplanzaTest> {
  final Map<String, List<String>> preguntas = {
    "AUTOCONTROL": [
      "“Controlo mis emociones” es:",
      "“Me cuesta mucho hacer régimen” es:"
    ],
    "PRUDENCIA / CAUTELA": [
      "“Evito actividades que resulten físicamente peligrosas” es:",
      "“A veces me equivoco al elegir amistades y relaciones” es:"
    ],
    "HUMILDAD Y MODESTIA": [
      "“Cambio de tema cuando la gente me halaga” es:",
      "“Suelo hablar de mis logros” es:"
    ],
  };
  int selectedValue = 0;
  int selectedValue2 = 0;
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: SafeArea(
          child: PageView(
        controller: controller,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(0),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(0).elementAt(0),
                  question2: preguntas.values.elementAt(0).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(0),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(1),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(1).elementAt(0),
                  question2: preguntas.values.elementAt(1).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(1),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(2),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(2).elementAt(0),
                  question2: preguntas.values.elementAt(2).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(2),
                ),
                SizedBox(
                  width: 120,
                  child: MaterialButton(
                    //padding: EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Terminar"),
                        Icon(Icons.upload),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
