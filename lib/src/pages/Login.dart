import 'package:flutter/material.dart';
import 'package:robbin/src/service/API.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Api ap = Api();
  bool login = false;
  bool loginValid = false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [descripcion(size), inputs(size), botonInicio(size)],
      ),
    ));
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
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Text("Sign in to continue",
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
              onChanged: (value) {
                loginValid = false;
                setState(() {});
              },
              controller: _controllerName,
              decoration: InputDecoration(hintText: 'Usuario'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (v) {
                loginValid = false;
                setState(() {});
              },
              controller: _controllerPassword,
              decoration: InputDecoration(
                  counterText: !loginValid ? '' : 'Error de credenciales',
                  counterStyle: TextStyle(color: Colors.red),
                  hintText: 'Password'),
            ),
          )
        ],
      ),
    );
  }

  Widget botonInicio(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 100)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                logearse();
              },
              child: login
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 4,
                      ),
                    )
                  : Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
          TextButton(onPressed: () {}, child: Text("Olvido su password?")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No tienes una cuenta?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'registro');
                  },
                  child: const Text("SignUp"))
            ],
          )
        ],
      ),
    );
  }

  void logearse() async {
    print(_controllerName.text);
    setState(() {
      login = true;
    });
    final respo =
        await ap.login(_controllerName.text, _controllerPassword.text);

    if (respo.isNotEmpty && respo == "ok") {
      print(respo);
      setState(() {});
      login = false;
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      loginValid = true;
      login = false;
      setState(() {});
      print("error");
    }
  }
}
