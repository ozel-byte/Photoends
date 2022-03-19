import 'package:flutter/material.dart';
import 'package:robbin/src/service/API.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api ap = Api();
  bool login = false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [logo(size), fondo(size), descripcion(size), botones(size)],
      ),
    );
  }

  Widget logo(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "PhotoEnts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget fondo(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/img3.png"))),
    );
  }

  Widget descripcion(Size size) {
    return Container(
      width: size.width * 1,
      height: size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Hello!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text("Este es el mejor lugar para guardar y compartir"),
          Text("tus mejores momentos.")
        ],
      ),
    );
  }

  Widget botones(Size size) {
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
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 100)),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.blue))),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'registro');
              },
              child: Text("SignUp"))
        ],
      ),
    );
  }
}
