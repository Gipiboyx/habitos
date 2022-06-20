import 'package:flutter/material.dart';
import 'package:habitos/screens/cuestionario_inicial.dart';
import 'package:habitos/screens/fortalezas_screen.dart';
import 'package:habitos/screens/portafolio_screen.dart';
import 'package:habitos/screens/prueba.dart';
import 'package:habitos/strengths_weaknesses_tests/humanidad_amor_test.dart';
import 'package:habitos/strengths_weaknesses_tests/justicia_test.dart';
import 'package:habitos/strengths_weaknesses_tests/sabiduria_conocimiento_test.dart';
import 'package:habitos/strengths_weaknesses_tests/templanza_test.dart';
import 'package:habitos/strengths_weaknesses_tests/trascendencia_test.dart';
import 'package:habitos/strengths_weaknesses_tests/valor_test.dart';
import 'package:habitos/widgets/card_background.dart';

class SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const SingleCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: this.color,
          child: Icon(
            this.icon,
            size: 35,
            color: Colors.white,
          ),
          radius: 35,
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            switch (this.text) {
              case "Prueba del Bienestar":
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PruebaInicial()));
                break;
              case "Portafolio de evidencias":
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PortafolioScreen()));
                break;
              case "Fortalezas":
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FortalezasScreen()));
                break;
              case "Sabiduria y Conocimiento":
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SabiduriaConocimientoTest()));
                break;
              case "Valor":
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ValorTest()));
                break;
              case "Humanidad y Amor":
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HumanidadAmorTest()));
                break;
              case "Justicia":
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JusticiaTest()));
                break;
              case "Templanza":
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TemplanzaTest()));
                break;
              case "Trascendencia":
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrascendenciaTest()));
                break;
              case "Progreso":
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Prueba()));
                break;
            }
          },
          child: Text(
            this.text,
            style: TextStyle(color: this.color, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
    return CardBackground(child: column);
  }
}
