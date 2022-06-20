import 'package:flutter/material.dart';
import 'package:habitos/widgets/page_view.dart';

class ValorTest extends StatefulWidget {
  const ValorTest({Key? key}) : super(key: key);

  @override
  State<ValorTest> createState() => _ValorTestState();
}

class _ValorTestState extends State<ValorTest> {
  final Map<String, List<String>> preguntas = {
    "VALOR Y VALENTÍA": [
      "“A menudo defiendo mi postura ante una oposición fuerte” es:",
      "“Los demás pocas veces me piden consejo” es:"
    ],
    "PERSEVERANCIA": [
      "“Siempre acabo lo que empiezo” es:",
      "“Me distraigo mientras trabajo” es: "
    ],
    "HONESTIDAD / INTEGRIDAD": [
      "“Siempre mantengo mis promesas” es:",
      "“Mis amigos nunca me dicen que soy realista” es:"
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
