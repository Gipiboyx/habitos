import 'package:flutter/material.dart';
import 'package:habitos/ui/colors.dart';
import 'package:habitos/widgets/custom_text.dart';
import 'package:habitos/widgets/large_text.dart';
import 'package:habitos/widgets/responsive_button.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List images = ["welcome-one.png", "welcome-two.png", "welcome-three.png"];
  List textTitle = ["!Bienvenido!", "", ""];

  List bodyText = [
    "Este el comienzo de un largo viaje \ndonde la constancia y disciplina serán\n claves para cumplir con tus objetivos.",
    "A lo largo de nuestras hemos\nadpotado distíntos hábitos\ntanto buenos y malos; refozar\ny cambiarlos es una lucha\ncostante de cada día.",
    "Dejános felicitarte de antemano por tener\nla intención de querer un cambio para ti\nel primer paso siempre es el más\nimportante y nada fácil de dar. \nVeamos las herramientas que tenemos\npara ayudarte en tu viaje."
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: images.length,
      itemBuilder: (_, index) {
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/" + images[index],
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index == 0 ? LargeText(text: textTitle[index]) : SizedBox(),
                    SizedBox(height: 20),
                    CustomText(text: bodyText[index]),
                    SizedBox(height: 20),
                    index == 2 ? ResponsiveButton() : SizedBox(),
                  ],
                ),
                Column(
                  children: List.generate(3, (indexDots) {
                    return Container(
                      width: 8,
                      height: index == indexDots ? 20 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index == indexDots
                            ? AppColors.mainColor
                            : AppColors.mainColor.withOpacity(0.3),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
