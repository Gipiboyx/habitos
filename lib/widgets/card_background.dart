import 'dart:ui';

import 'package:flutter/material.dart';

class CardBackground extends StatelessWidget {
  final Widget child;

  const CardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        //borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            //
            height: 180,
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 234, 154, 0.7),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]),
            child: this.child,
          ),
        ),
      ),
    );
  }
}
