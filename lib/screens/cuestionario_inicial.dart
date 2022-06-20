import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PruebaInicial extends StatefulWidget {
  const PruebaInicial({Key? key}) : super(key: key);

  @override
  State<PruebaInicial> createState() => _PruebaInicialState();
}

class _PruebaInicialState extends State<PruebaInicial> {
  final List<TextEditingController> values =
      List.generate(13, (index) => TextEditingController());
  int resultado1 = 0;
  int resultado2 = 0;
  int resultado3 = 0;
  int resultado4 = 0;
  List<bool> emptyFields = List.generate(13, (index) => false);

  final List<String> seccion1 = [
    "Si algo me sale mal puedo aceptarlo, admitirlo.",
    "Puedo aceptar mis equivocaciones y tratar de mejorar.",
    "Encaró sin mayores problemas mis obligaciones diarias"
  ];
  final List<String> seccion2 = [
    "Puedo decir lo que pienso sin mayores problemas",
    "En general hago lo que quiero, soy poco influenciable",
    "Puedo tomar decisiones sin dudar mucho"
  ];
  final List<String> seccion3 = [
    "Generalmente le caigo bien a la gente",
    "Cuento con personas que me ayudan si lo necesito",
    "Creo que en general me llevo bien con la gente"
  ];
  final List<String> seccion4 = [
    "Creo que sé lo que quiero hacer con mi vida",
    "Me importa pensar qué haré en el futuro",
    "Siento que podré lograr las metas que me proponga",
    "Soy una persona capaz de pensar en un proyecto para mi vida"
  ];

  @override
  void initState() {
    for (int i = 0; i < values.length; i++) {
      values[i].addListener(() {
        setState(() {
          emptyFields[i] = values[i].text.isEmpty;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var i = 0; i < values.length; i++) {
      values[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: [
            Bieps(
                preguntas: seccion1,
                value1: values[0],
                value2: values[1],
                value3: values[2]),
            Bieps(
                preguntas: seccion2,
                value1: values[3],
                value2: values[4],
                value3: values[5]),
            Bieps(
                preguntas: seccion3,
                value1: values[6],
                value2: values[7],
                value3: values[8]),
            Bieps4(
                preguntas: seccion4,
                value1: values[9],
                value2: values[10],
                value3: values[11],
                value4: values[12]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isEmptyFields(values)
            ? null
            : () async {
                int totalPrimeraSecc = int.parse(values[0].text) +
                    int.parse(values[1].text) +
                    int.parse(values[2].text);
                String resultado1 = totalPrimeraSecc < 5
                    ? " Tiene dificultades en manejar los asuntos de la vida diaria. No se da cuenta de las oportunidades. Cree que es incapaz de modificar el ambiente. Esta desilusionado respecto de su vida pasada. Le gustaría ser diferente de como es. Se siente insatisfecho consigo mismo."
                    : "Tiene una sensación de control y de auto competencia. Puede crear o manipular contextos para adecuarlo a sus propias necesidades o intereses. Puede aceptar los múltiples aspectos de sí mismo incluyendo los buenos y los malos. Se siente bien acerca del pasado ";
                int totalSegundaSecc = int.parse(values[3].text) +
                    int.parse(values[4].text) +
                    int.parse(values[5].text);
                String resultado2 = totalSegundaSecc < 5
                    ? "Tiene pocas relaciones con los demás. Es aislado. Se siente frustrado en los vínculos que establece con los demas. No puede hacer compromisos con los demás. "
                    : "Es cálido. Confía en los demás. Puede establecer buenos vínculos. Tiene capacidad empática y afectiva.";
                int totalTerceraSecc = int.parse(values[6].text) +
                    int.parse(values[7].text) +
                    int.parse(values[8].text);
                String resultado3 = totalTerceraSecc < 5
                    ? "Emocionalmente inestable. Depende de los demás para tomar decisiones. Le preocupa lo que piensan otros."
                    : "Puede tomar decisiones de modo independiente. Es asertivo: confia en su propio juicio.";
                int totalCuartaSecc = int.parse(values[9].text) +
                    int.parse(values[10].text) +
                    int.parse(values[11].text) +
                    int.parse(values[12].text);
                String resultado4 = totalCuartaSecc < 7
                    ? "La vida carece de sentido y significado. Tiene pocas metas y proyectos. No puede establecer que la vida tiene algun propósito."
                    : "Tiene metas y proyectos den la vida. Considera que la vida tiene significado. Tiene valores que hacen que la vida tenga significado.";
                try {
                  String? user = FirebaseAuth.instance.currentUser!.email;
                  FirebaseFirestore.instance
                      .collection("Bieps")
                      .doc(user)
                      .update({
                    "bieps1": resultado1,
                    "bieps2": resultado2,
                    "bieps3": resultado3,
                    "bieps4": resultado4,
                  });
                  Navigator.pop(context);
                } on FirebaseFirestore catch (e) {
                  print(e);
                }
              },
        child: Icon(Icons.upload),
      ),
    );
  }
}

bool isEmptyFields(List<TextEditingController> campos) {
  bool aux = true;
  for (var i = 0; i < campos.length; i++) {
    if (campos[i].text.isEmpty) {
      aux = true;
      break;
    } else {
      aux = false;
    }
  }
  return aux;
}

class Bieps extends StatelessWidget {
  const Bieps({
    Key? key,
    required this.preguntas,
    required this.value1,
    required this.value2,
    required this.value3,
  }) : super(key: key);

  final List<String> preguntas;
  final TextEditingController value1;
  final TextEditingController value2;
  final TextEditingController value3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30),
          Image.asset('assets/BIEPS-A.png'),
          SizedBox(height: 30),
          Text(
            'BIEPS-A',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 30),
          Pregunta(
            val: value1,
            textoPregunta: preguntas[0],
          ),
          Pregunta(
            val: value2,
            textoPregunta: preguntas[1],
          ),
          Pregunta(
            val: value3,
            textoPregunta: preguntas[2],
          ),
        ],
      ),
    );
  }
}

class Bieps4 extends StatelessWidget {
  const Bieps4({
    Key? key,
    required this.preguntas,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
  }) : super(key: key);

  final List<String> preguntas;
  final TextEditingController value1;
  final TextEditingController value2;
  final TextEditingController value3;
  final TextEditingController value4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30),
          Image.asset('assets/BIEPS-A.png'),
          SizedBox(height: 30),
          Text(
            'BIEPS-A',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 30),
          Pregunta(
            val: value1,
            textoPregunta: preguntas[0],
          ),
          Pregunta(
            val: value2,
            textoPregunta: preguntas[1],
          ),
          Pregunta(
            val: value3,
            textoPregunta: preguntas[2],
          ),
          Pregunta(
            val: value4,
            textoPregunta: preguntas[3],
          ),
        ],
      ),
    );
  }
}

class Pregunta extends StatefulWidget {
  final String textoPregunta;
  final TextEditingController val;

  Pregunta({
    Key? key,
    required this.val,
    required this.textoPregunta,
  }) : super(key: key);

  @override
  State<Pregunta> createState() => _PreguntaState(val, textoPregunta);
}

class _PreguntaState extends State<Pregunta> {
  TextEditingController val;
  String textoPregunta;

  _PreguntaState(this.val, this.textoPregunta);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(textoPregunta),
        SizedBox(height: 20),
        Form(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 190),
            child: TextFormField(
                controller: val,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null && (value == "" || int.parse(value) > 3)) {
                    //val.text = "";
                    return "Ingresa un número entre el 1 y el 3";
                  } else
                    return null;
                }),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

bool verificar(List<String> values) {
  bool resultado = true;
  List<int> aux = [];
  for (int i = 0; i < values.length; i++) {
    aux[i] = int.parse(values[i]);
  }
  int j = 0;
  while (j < aux.length) {
    if (aux[j] <= 3)
      j++;
    else {
      resultado = false;
      break;
    }
  }
  return resultado;
}
