import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageViewTest extends StatefulWidget {
  final int bandera;
  final String question;
  int selectedValue;

  PageViewTest({
    Key? key,
    required this.question,
    required this.selectedValue,
    required this.bandera,
  }) : super(key: key);

  @override
  State<PageViewTest> createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewTest> {
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
          value: widget.bandera == 1 ? 5 : 1,
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
          title: Text(options[0]),
        ),
        RadioListTile<int>(
          value: widget.bandera == 1 ? 4 : 2,
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
          value: widget.bandera == 1 ? 2 : 4,
          title: Text(options[3]),
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
        ),
        RadioListTile<int>(
          value: widget.bandera == 1 ? 1 : 5,
          title: Text(options[4]),
          groupValue: widget.selectedValue,
          onChanged: (value) => setState(() {
            widget.selectedValue = value!;
          }),
        ),
      ],
    );
  }
}
