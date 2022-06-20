import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageTest extends StatefulWidget {
  final String identificador;
  final String question;
  final String question2;
  int selectedValue;
  int selectedValue2;

  PageTest(
      {Key? key,
      required this.question,
      required this.question2,
      required this.selectedValue,
      required this.selectedValue2,
      required this.identificador})
      : super(key: key);

  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  final List<String> options = [
    "Muy propia de mí",
    "Propia de mí",
    "Neutra",
    "Poco propia de mí",
    "Impropia de mí",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question, style: Theme.of(context).textTheme.headline6),
        RadioListTile<int>(
          value: 5,
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
          title: Text(options[0]),
        ),
        RadioListTile<int>(
          value: 4,
          title: Text(options[1]),
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
        ),
        RadioListTile<int>(
          value: 3,
          title: Text(options[2]),
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
        ),
        RadioListTile<int>(
          value: 2,
          title: Text(options[3]),
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
        ),
        RadioListTile<int>(
          value: 1,
          title: Text(options[4]),
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
        ),
        Text(widget.question2, style: Theme.of(context).textTheme.headline6),
        RadioListTile<int>(
          value: 1,
          groupValue: widget.selectedValue2,
          onChanged: (value) => setState(() {
            widget.selectedValue2 = value!;
          }),
          title: Text(options[0]),
        ),
        RadioListTile<int>(
          value: 2,
          title: Text(options[1]),
          groupValue: widget.selectedValue2,
          onChanged: (value) => setState(() {
            widget.selectedValue2 = value!;
          }),
        ),
        RadioListTile<int>(
          value: 3,
          title: Text(options[2]),
          groupValue: widget.selectedValue2,
          onChanged: (value) => setState(() {
            widget.selectedValue2 = value!;
          }),
        ),
        RadioListTile<int>(
          value: 4,
          title: Text(options[3]),
          groupValue: widget.selectedValue2,
          onChanged: (value) => setState(() {
            widget.selectedValue2 = value!;
          }),
        ),
        RadioListTile<int>(
          value: 5,
          title: Text(options[4]),
          groupValue: widget.selectedValue2,
          onChanged: (value) => setState(() {
            widget.selectedValue2 = value!;
          }),
        ),
        ElevatedButton(
          onPressed: () {
            List<dynamic> fortalezas = [];
            List<dynamic> debilidades = [];

            FirebaseFirestore.instance
                .collection("Estudiantes")
                .doc(user)
                .get()
                .then((value) {
              fortalezas = value.get("Fortalezas");
              debilidades = value.get("Debilidades");

              int res = 0;
              res = widget.selectedValue + widget.selectedValue2;
              if (res > 6) {
                fortalezas.add(widget.identificador);
                for (var i = 0; i < debilidades.length; i++) {
                  if (widget.identificador == debilidades[i]) {
                    debilidades.remove(widget.identificador);
                  }
                }
              } else {
                debilidades.add(widget.identificador);
                for (var i = 0; i < fortalezas.length; i++) {
                  if (widget.identificador == fortalezas[i]) {
                    fortalezas.remove(widget.identificador);
                  }
                }
              }
              FirebaseFirestore.instance
                  .collection("Estudiantes")
                  .doc(user)
                  .update({
                "Debilidades": debilidades,
                "Fortalezas": fortalezas,
              });
            });
          },
          child: Icon(Icons.check),
        )
      ],
    );
  }
}
