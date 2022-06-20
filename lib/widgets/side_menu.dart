import 'package:flutter/material.dart';
import 'package:habitos/widgets/side_single_card.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xfff4f1bb),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(),
          SideSingleCard(
              icon: Icons.health_and_safety_rounded,
              color: Colors.red,
              text: 'Percepción del bienestar'),
          SideSingleCard(
              icon: Icons.cases_rounded,
              color: Colors.brown,
              text: 'Portafolio de evidencias'),
          SideSingleCard(
              icon: Icons.animation, color: Colors.blue, text: 'Inspirame'),
          SideSingleCard(
              icon: Icons.check_box, color: Colors.green, text: 'Progeso'),
          SideSingleCard(
              icon: Icons.fitness_center,
              color: Color.fromARGB(255, 193, 177, 42),
              text: 'Fortalezas'),
          SideSingleCard(
              icon: Icons.analytics,
              color: Colors.purple,
              text: 'Prueba Inicial'),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu_lateral.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
