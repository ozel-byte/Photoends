import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:robbin/src/service/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubirPost extends StatefulWidget {
  SubirPost({Key? key}) : super(key: key);

  @override
  State<SubirPost> createState() => _SubirPostState();
}

class _SubirPostState extends State<SubirPost> {
  double validReadPublicacion = 450;
  String? _image;
  var _imagev2;
  String? key = "";

  @override
  void initState() {
    super.initState();
    loadKey();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    validReadPublicacion = 450;
                    _image = null;
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          Text(
            "Subir Publicacion",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: size.width * 0.8,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.pink[200],
                  borderRadius: BorderRadius.circular(10)),
              child: _image != null
                  ? Image.file(
                      File(_image!),
                      fit: BoxFit.contain,
                    )
                  : Center(child: Text("Comparte una foto"))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onTap: () {
                validReadPublicacion = 750;
                setState(() {});
              },
              decoration: InputDecoration(hintText: "Ingrese una descripcion"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                cargarImg();
              },
              child: Text("Cargar Imagen")),
          TextButton(
              onPressed: () async {
                if (_image != null) {
                  final resp = await Api().sendImg(_image, key);
                  print(resp);
                  if (resp == "ok") {
                    print("entro aqui");
                    Navigator.pop(context);
                  }
                }
              },
              child: Text("Publicar"))
        ],
      ),
    );
  }

  void cargarImg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    _image = result!.files.single.path;

    setState(() {});
  }

  void loadKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      key = prefs.getString('key');
    });
  }
}
