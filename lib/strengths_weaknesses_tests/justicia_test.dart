import 'package:flutter/material.dart';
import 'package:habitos/widgets/page_view.dart';

class JusticiaTest extends StatefulWidget {
  const JusticiaTest({Key? key}) : super(key: key);

  @override
  State<JusticiaTest> createState() => _JusticiaTestState();
}

class _JusticiaTestState extends State<JusticiaTest> {
  final Map<String, List<String>> preguntas = {
    "CIVISMO / TRABAJO EN EQUIPO / LEALTAD": [
      "“Doy lo mejor de mí en el trabajo en grupo” es:",
      "“Me cuesta sacrificar mis propios intereses en beneficio de los grupos a los que pertenezco” es:"
    ],
    "IMPARCIALIDAD Y EQUIDAD": [
      "“Trato a las personas con igualdad independientemente de quienes sean” es:",
      "“Si alguien no me cae bien me cuesta tratarlo con justicia” es:"
    ],
    "LIDERAZGO": [
      "“Siempre consigo que las personas cumplan su cometido sin insistir en exceso” es:",
      "“No se me da demasiado bien organizar actividades de grupo” es:"
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
