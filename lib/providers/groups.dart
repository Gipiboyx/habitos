import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupsList extends StatefulWidget {
  const GroupsList({Key? key}) : super(key: key);

  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  String _profesor = "Selecciona un opción";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Grupos").snapshots(),
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
                    _profesor = e!.get("grupo");
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
