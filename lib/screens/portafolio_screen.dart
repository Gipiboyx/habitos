import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PortafolioScreen extends StatefulWidget {
  const PortafolioScreen({Key? key}) : super(key: key);

  @override
  State<PortafolioScreen> createState() => _PortafolioScreenState();
}

class _PortafolioScreenState extends State<PortafolioScreen> {
  String _habito = "Escoge el hábito";
  String _idHabito = "";
  int nEvidenciasHabito = 0;
  String? user = FirebaseAuth.instance.currentUser!.email;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    try {
      final path = '${FirebaseAuth.instance.currentUser!.email}/' +
          _habito +
          '/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      setState(() {
        uploadTask = null;
      });
      DateTime date = DateTime.now();
      String fechaRegs = date.year.toString() +
          "-" +
          date.month.toString() +
          "-" +
          date.day.toString();
      print(_habito);
      FirebaseFirestore.instance
          .collection("Habitos_Asignados")
          .where('Nombre', isEqualTo: _habito)
          .where('Correo', isEqualTo: user)
          .get()
          .then((value) {
        _idHabito = value.docs[0].get('Id_Hab');
        Map<String, String> data = {
          "Link": urlDownload,
          "Fecha_de_registro": fechaRegs,
          "Correo": user!,
          "Estatus": "No validado",
          "id_habito": _idHabito,
          "Nombre_habito": _habito,
          "Comentarios": "",
        };
        FirebaseFirestore.instance
            .collection("Evidencias")
            .doc(user! + "-" + _idHabito + "-" + nEvidenciasHabito.toString())
            .set(data);
      });
    } on FirebaseStorage catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseStorage.instance.ref('$user/' + _habito).listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portafolio de Evidencias"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Habitos_Asignados")
            .snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton(
                  isExpanded: true,
                  items: snapshot.data!.docs
                      .where((element) => element.get("Correo") == user)
                      .map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.get("Nombre").toString(),
                      ),
                    );
                  }).toList(),
                  onChanged: (QueryDocumentSnapshot<Object?>? e) {
                    setState(() {
                      _habito = e!.get("Nombre");
                    });
                  },
                  hint: Text(_habito),
                ),
              ),
              Text("Selecicona tu evidencia: "),
              ElevatedButton(onPressed: selectFile, child: Text("Examinar")),
              Text((pickedFile != null) ? "${pickedFile!.name}" : ""),
              ElevatedButton(
                  onPressed: uploadFile, child: Text("Subir Evidencia")),
              buildProgress(),
            ],
          );
        }),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    "${(100 * progress).roundToDouble()}%",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox(height: 50);
        }
      }));
}
