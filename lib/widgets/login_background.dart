import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _PurpleBox(),
        SafeArea(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 130, maxWidth: 130),
              child: Image.asset('assets/Habitos.png'),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _buildBoxDecoration(),
      child: Stack(
        children: const [
          Positioned(
            child: _Bubble(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _Bubble(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: _Bubble(),
            top: 50,
            right: -20,
          ),
          Positioned(
            child: _Bubble(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: _Bubble(),
            bottom: 120,
            right: 20,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 70, 156, 255),
            Color.fromARGB(255, 70, 156, 255),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomStart,
        ),
      );
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
