import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/widgets/side_menu.dart';
import 'package:habitos/widgets/single_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var apiURL = 'https://type.fit/api/quotes';
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
      appBar: AppBar(
        title: Text('¡Bienvenido!', maxLines: 2),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      drawer: SideMenu(),
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
                          icon: Icons.cases_rounded,
                          color: Colors.brown,
                          text: 'Portafolio de evidencias'),
                      SingleCard(
                          icon: Icons.check_box,
                          color: Colors.green,
                          text: 'Progreso'),
                    ]),
                    TableRow(children: [
                      SingleCard(
                          icon: Icons.fitness_center,
                          color: Color.fromARGB(255, 193, 177, 42),
                          text: 'Fortalezas'),
                      SingleCard(
                          icon: Icons.analytics,
                          color: Colors.purple,
                          text: 'Prueba del Bienestar'),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Icon(Icons.logout_sharp),
      ),
    );
  }
}
