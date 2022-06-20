import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/widgets/card_container.dart';
import 'package:habitos/widgets/login_background.dart';
import 'package:habitos/widgets/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(
                children: [
                  Text('Ingresa tu correo para poder restaurar tu contraseña',
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 30),
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: resetPassword,
                    icon: Icon(Icons.email_outlined),
                    label: Text(
                      'Restaurar Contraseña',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Link de restauración enviado al correo electrónico');

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
