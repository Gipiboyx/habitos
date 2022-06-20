import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habitos/main.dart';
import 'package:habitos/widgets/card_container.dart';
import 'package:habitos/widgets/login_background.dart';
import 'package:habitos/widgets/utils.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _profesor = "";
  String _grupo = "";
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    '¡Hey, Bienvenido!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: idController,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Boleta'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(labelText: 'Correo Electrónico'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Ingresa un correo electrónico válido'
                            : null,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'La contraseña debe tener mínimo 6 caracteres'
                        : null,
                  ),
                  SizedBox(height: 30),
                  Text("Profesor"),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("profesores")
                        .snapshots(),
                    builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: DropdownButton(
                              isExpanded: true,
                              items: snapshot.data!.docs.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.get("name").toString(),
                                  ),
                                );
                              }).toList(),
                              onChanged: (QueryDocumentSnapshot<Object?>? e) {
                                setState(() {
                                  _profesor = e!.get("name");
                                });
                              },
                              hint: Text(_profesor),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Text("Grupo"),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Grupos")
                        .where('estatus', isEqualTo: "Habilitado")
                        .snapshots(),
                    builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: DropdownButton(
                              isExpanded: true,
                              items: snapshot.data!.docs.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.get("grupo").toString(),
                                  ),
                                );
                              }).toList(),
                              onChanged: (QueryDocumentSnapshot<Object?>? e) {
                                setState(() {
                                  _grupo = e!.get("grupo");
                                });
                              },
                              hint: Text(_grupo),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  ElevatedButton.icon(
                    onPressed: signUp,
                    icon: Icon(Icons.lock_open),
                    label: Text(
                      'Registrarte',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.brown, fontSize: 20),
                      text: '¿Ya tienes una cuenta?',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: '¡Inicia Sesión!',
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
          ),
        ]),
      ),
    );
  }

  Future signUp() async {
    // final isValid = formKey.currentState!.validate as bool;
    //  if (!isValid) return;
    String idProfesor = "";
    String idGrupo = "";
    String? _token = await FirebaseMessaging.instance.getToken();

    FirebaseFirestore.instance
        .collection("profesores")
        .where('name', isEqualTo: _profesor)
        .get()
        .then(
          (value) => idProfesor = value.docs[0].get("employee_number"),
        );
    FirebaseFirestore.instance
        .collection("Grupos")
        .where('grupo', isEqualTo: _grupo)
        .where('estatus', isEqualTo: 'Habilitado')
        .get()
        .then(
          (value) => idGrupo = value.docs[0].get("id"),
        );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      List<String> fortalezas = [];
      List<String> debilidades = [];
      Map<String, dynamic> data = Map<String, dynamic>();
      data.addAll({
        //'e-mail': emailController.text.trim(),
        'Nombre': nameController.text,
        'Boleta': idController.text,
        'Profesor': idProfesor,
        'Grupo': _grupo,
        'id_grupo': idGrupo,
        'Fortalezas': fortalezas,
        'Debilidades': debilidades,
        'Estatus': "No verificado",
        'Token': _token
      });
      FirebaseFirestore.instance
          .collection("Estudiantes")
          .doc(emailController.text)
          .set(data);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
