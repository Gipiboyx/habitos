import 'package:flutter/material.dart';
import 'package:habitos/widgets/page_view.dart';

class HumanidadAmorTest extends StatefulWidget {
  const HumanidadAmorTest({Key? key}) : super(key: key);

  @override
  State<HumanidadAmorTest> createState() => _HumanidadAmorTestState();
}

class _HumanidadAmorTestState extends State<HumanidadAmorTest> {
  final Map<String, List<String>> preguntas = {
    "BONDAD Y GENEROSIDAD": [
      "“El mes pasado ayudé voluntariamente a un vecino” es:",
      "“Raras veces me emociona tanto la buena suerte de los demás como la mía propia” es:"
    ],
    "AMAR Y DEJARSE AMAR": [
      "“Hay personas en mi vida que se preocupan tanto por mis sentimientos y bienestar como por los suyos propios” es:",
      "“Me cuesta aceptar el amor de los demás” es:"
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
