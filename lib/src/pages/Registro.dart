import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:robbin/src/service/API.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controlPassowrd = TextEditingController();
  final TextEditingController _controllermail = TextEditingController();
  bool validRegistro = false;
  bool validRegistroError = false;
  bool validCamposVacios = false;
  String? _image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [descripcion(size), inputs(size), botonInicio(size)],
        ),
      ),
    );
  }

  Widget descripcion(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Registro!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                Text("Crea una cuenta para ver",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
                Text("lo que comparten tus amigos")
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputs(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _image != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  backgroundImage: FileImage(File(_image!)),
                  child: IconButton(
                      onPressed: () {
                        cargarImg();
                      },
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.white.withOpacity(0.6),
                      )),
                )
              : CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: IconButton(
                      onPressed: () {
                        cargarImg();
                      },
                      icon: Icon(Icons.photo_camera)),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (v) {
                validCamposVacios = false;
                setState(() {});
              },
              controller: _controllerName,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Usuario'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (v) {
                validCamposVacios = false;
                setState(() {});
              },
              controller: _controllermail,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Correo'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (v) {
                validCamposVacios = false;
                setState(() {});
              },
              controller: _controlPassowrd,
              decoration: InputDecoration(
                  counterText: validCamposVacios
                      ? 'Rellena los campos'
                      : validRegistroError
                          ? 'No se pudo crear la cuenta'
                          : '',
                  enabledBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  counterStyle: TextStyle(color: Colors.red),
                  hintText: 'Password'),
            ),
          ),
        ],
      ),
    );
  }

  Widget botonInicio(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                registro();
              },
              child: !validRegistro
                  ? Text(
                      "Registrar",
                      style: TextStyle(color: Colors.white),
                    )
                  : CircularProgressIndicator(
                      color: Colors.white,
                    )),
        ],
      ),
    );
  }

  void registro() async {
    if (_controlPassowrd.text.isEmpty ||
        _controllerName.text.isEmpty ||
        _image == null) {
      validRegistroError = false;
      validRegistro = false;
      setState(() {
        validCamposVacios = true;
      });
    } else {
      print("entro aqui");
      validCamposVacios = false;
      validRegistro = true;
      setState(() {});
      final resp = await Api().registro(_controllerName.text,
          _controlPassowrd.text, _image, _controllermail.text);

      if (resp == "ok") {
        setState(() {
          validRegistro = false;
        });
        guardarIdSharedPreferences();
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        setState(() {
          validRegistroError = true;
          validRegistro = false;
        });
      }
    }
  }

  void cargarImg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    _image = result!.files.single.path;

    setState(() {});
  }

  void guardarIdSharedPreferences() {}
}
