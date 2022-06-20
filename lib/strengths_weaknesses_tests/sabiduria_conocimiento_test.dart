import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/widgets/page_view.dart';

class SabiduriaConocimientoTest extends StatefulWidget {
  const SabiduriaConocimientoTest({Key? key}) : super(key: key);

  @override
  State<SabiduriaConocimientoTest> createState() =>
      _SabiduriaConocimientoTestState();
}

class _SabiduriaConocimientoTestState extends State<SabiduriaConocimientoTest> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  final Map<String, List<String>> preguntas = {
    "CURIOSIDAD": [
      "La afirmación “Siempre siento curiosidad por el mundo” es:",
      "La frase “Me aburro con facilidad” es: "
    ],
    "AMOR POR EL CONOCIMIENTO": [
      "La afirmación “Me emociono cuando aprendo algo nuevo” es:",
      "La frase “Nunca me desvió de mi camino para visitar museos u otros lugares educativos” es: "
    ],
    "JUICIO / MENTALIDAD ABIERTA": [
      "La afirmación “Cuando la situación lo exige, puedo pensar muy racionalmente” es: ",
      "“Tiendo a emitir juicios precipitados” es:"
    ],
    "INGENIO / ORIGINALIDAD / PERSPICACIA": [
      "“Me gusta pensar en nuevas formas de hacer las cosas” es:",
      "“La mayoría de mis amigos son más imaginativos que yo” es:"
    ],
    "INTELIGENCIA SOCIAL / PERSONAL / EMOCIONAL": [
      "“Independientemente de la situación social, soy capaz de encajar” es:",
      "“No se me da demasiado bien advertir lo que sienten otras personas” es:"
    ],
    "PERSPECTIVA": [
      "“Siempre soy capaz de analizar las cosas y verlas en un contexto más amplio” es:",
      "“Los demás pocas veces me piden consejo” es:"
    ],
  };
  int selectedValue1 = 0;
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
                  selectedValue: selectedValue1,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(0),
                ),
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
                  selectedValue: selectedValue1,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(1),
                ),
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
                  selectedValue: selectedValue1,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(2),
                ),
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
                  selectedValue: selectedValue1,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(3),
                ),
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
                  selectedValue: selectedValue1,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(4),
                ),
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
                  selectedValue: selectedValue1,
                  selectedValue2: selectedValue2,
                  identificador: preguntas.keys.elementAt(5),
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
