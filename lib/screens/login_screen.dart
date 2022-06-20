import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habitos/main.dart';
import 'package:habitos/screens/forgot_password_screen.dart';
import 'package:habitos/widgets/card_container.dart';
import 'package:habitos/widgets/login_background.dart';
import 'package:habitos/widgets/utils.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBackground(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 250,
          ),
          CardContainer(
            child: Column(
              children: [
                Text('Iniciar Sesión',
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.blue,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: singIn,
                  icon: Icon(Icons.lock_open),
                  label: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Text(
                    '¿Olvidaste la contrseña?',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.brown, fontSize: 20),
                    text: '¿No tienes cuenta?',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: '¡Registrate!',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future singIn() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
