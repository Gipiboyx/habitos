import 'package:flutter/material.dart';
import 'package:habitos/widgets/card_background.dart';

class SideSingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const SideSingleCard({
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
          radius: 30,
        ),
        SizedBox(height: 10),
        Text(
          this.text,
          style: TextStyle(color: this.color, fontSize: 18),
          textAlign: TextAlign.center,
        )
      ],
    );
    return CardBackground(child: column);
  }
}
