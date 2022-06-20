import 'package:flutter/material.dart';
import 'package:habitos/screens/login_screen.dart';
import 'package:habitos/screens/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginScreen(onClickedSignUp: toogle)
        : SignUpScreen(onClickedSignIn: toogle);
  }

  void toogle() => setState(() {
        isLogin = !isLogin;
      });
}
