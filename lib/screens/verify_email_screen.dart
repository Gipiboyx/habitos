import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/welcome_screen.dart';
import 'package:habitos/widgets/card_container.dart';
import 'package:habitos/widgets/login_background.dart';
import 'package:habitos/widgets/utils.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerify = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerify) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 4), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerify) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 4));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerify
        ? WelcomeScreen()
        : LoginBackground(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    CardContainer(
                      child: Column(
                        children: [
                          Text(
                              'Un link de verificación ha sido enviado a su correo',
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 30),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50)),
                            onPressed:
                                canResendEmail ? sendVerificationEmail : null,
                            icon: Icon(Icons.email),
                            label: Text(
                              'Reenviar Correo',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50)),
                              onPressed: () => FirebaseAuth.instance.signOut(),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(fontSize: 24),
                              ))
                        ],
                      ),
                    ),
                  ]),
            ),
          );
  }
}
