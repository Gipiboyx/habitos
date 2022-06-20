import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeachersList extends StatefulWidget {
  String teacher;
  TeachersList({Key? key, required this.teacher}) : super(key: key);

  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  String _profesor = "Selecciona un opción";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("profesores").snapshots(),
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
                    widget.teacher = _profesor = e!.get("name");
                  });
                },
                hint: Text(_profesor),
              ),
            ),
          ],
        );
      }),
    );
  }
}
