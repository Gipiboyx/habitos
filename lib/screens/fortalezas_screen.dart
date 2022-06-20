import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitos/widgets/single_card.dart';

class FortalezasScreen extends StatelessWidget {
  const FortalezasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xffeaf2e3),
          Color(0xfff4f1bb),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 0.6],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text("¡Elije un Test!")),
      body: Stack(
        children: [
          Stack(children: [
            Container(decoration: boxDecoration),
          ]),
          SingleChildScrollView(
            child: Column(
              children: [
                Table(
                  children: [
                    TableRow(children: [
                      SingleCard(
                          icon: Icons.school,
                          color: Colors.brown,
                          text: 'Sabiduria y Conocimiento'),
                      SingleCard(
                          icon: Icons.health_and_safety,
                          color: Colors.green,
                          text: 'Valor'),
                    ]),
                    TableRow(children: [
                      SingleCard(
                          icon: Icons.self_improvement,
                          color: Color.fromARGB(255, 193, 177, 42),
                          text: 'Humanidad y Amor'),
                      SingleCard(
                          icon: FontAwesomeIcons.gavel,
                          color: Colors.purple,
                          text: 'Justicia'),
                    ]),
                    TableRow(children: [
                      SingleCard(
                          icon: FontAwesomeIcons.scaleUnbalancedFlip,
                          color: Colors.blue,
                          text: 'Templanza'),
                      SingleCard(
                          icon: FontAwesomeIcons.universalAccess,
                          color: Colors.red,
                          text: 'Trascendencia'),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
