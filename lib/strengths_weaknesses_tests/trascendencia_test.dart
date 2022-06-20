import 'package:flutter/material.dart';
import 'package:habitos/widgets/page_view.dart';

class TrascendenciaTest extends StatefulWidget {
  const TrascendenciaTest({Key? key}) : super(key: key);

  @override
  State<TrascendenciaTest> createState() => _TrascendenciaTestState();
}

class _TrascendenciaTestState extends State<TrascendenciaTest> {
  final Map<String, List<String>> preguntas = {
    "DISFRUTE DE LA BELLEZA Y LA EXCELENCIA": [
      "“El mes pasado, me he emocionado por la excelencia en música, arte, teatro, deporte, ciencia o matemáticas” es: ",
      "“No he creado nada bello el año pasado” es: "
    ],
    "GRATITUD": [
      "“Siempre digo gracias, incluso por pequeñas cosas” es:",
      "“Raras veces me detengo a dar las gracias” es: "
    ],
    "ESPERANZA / OPTIMISMO": [
      "“Siempre veo el lado bueno de las cosas” es:",
      "“Raras veces tengo un plan bien desarrollado de lo que quiero hacer”” es:"
    ],
    "ESPIRITUALIDAD / FE / RELIGIOSIDAD": [
      "“Mi vida tiene un propósito fuerte” es: ",
      "“No siento una vocación en la vida” es: "
    ],
    "PERDÓN Y CLEMENCIA": [
      "“Siempre pienso que lo pasado, pasado está” es:",
      "“Siempre intento desquitarme” es:"
    ],
    "PICARDÍA Y SENTIDO DEL HUMOR": [
      "“Combino el trabajo con la diversión en la mayor medida posible” es:",
      "“Raras veces digo cosas divertidas” es:"
    ],
    "PASIÓN / ENTUSIASMO": [
      "“Me implico por completo en todo lo que hago” es",
      "“Muchas veces me siento decaído” es: "
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
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(3),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(3).elementAt(0),
                  question2: preguntas.values.elementAt(3).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(3),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(4),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(4).elementAt(0),
                  question2: preguntas.values.elementAt(4).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(4),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(5),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(5).elementAt(0),
                  question2: preguntas.values.elementAt(5).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(5),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(preguntas.keys.elementAt(6),
                    style: Theme.of(context).textTheme.headline5),
                PageTest(
                  question: preguntas.values.elementAt(6).elementAt(0),
                  question2: preguntas.values.elementAt(6).elementAt(1),
                  selectedValue: selectedValue,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(6),
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
