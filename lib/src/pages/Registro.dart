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
  bool validRegistro = false;
  bool validRegistroError = false;
  bool validCamposVacios = false;
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
      height: size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Text("Create a new count",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18))
          ],
        ),
      ),
    );
  }

  Widget inputs(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (v) {
                validCamposVacios = false;
                setState(() {});
              },
              controller: _controllerName,
              decoration: InputDecoration(hintText: 'Usuario'),
            ),
          ),
          SizedBox(height: 30),
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
                      EdgeInsets.symmetric(horizontal: 100)),
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
    if (_controlPassowrd.text.isEmpty || _controllerName.text.isEmpty) {
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
      final resp =
          await Api().registro(_controllerName.text, _controlPassowrd.text);

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

  void guardarIdSharedPreferences() {}
}
