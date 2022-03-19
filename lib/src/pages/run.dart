import 'package:flutter/material.dart';
import 'package:robbin/src/pages/Home.dart';
import 'package:robbin/src/pages/HomePage.dart';
import 'package:robbin/src/pages/Login.dart';
import 'package:robbin/src/pages/Registro.dart';

class Run extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => Login(),
        'registro': (BuildContext context) => Registro(),
        'home': (BuildContext context) => Home()
      },
    );
  }
}
