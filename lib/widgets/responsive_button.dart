import 'package:flutter/material.dart';
import 'package:habitos/screens/home_screen.dart';
import 'package:habitos/ui/colors.dart';

// ignore: must_be_immutable
class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;

  ResponsiveButton({Key? key, this.isResponsive = false, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      child: MaterialButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset('assets/button-one.png')]),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainColor,
      ),
    );
  }
}
