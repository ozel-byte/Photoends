import 'dart:html';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? key = "";
  SharedPreferences? shared;
  @override
  void initState() {
    super.initState();
    loadKey();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                )),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
            SizedBox(
              width: 10,
            )
          ],
          title: Text(
            "PhotoEnds",
            style: TextStyle(color: Colors.black),
          )),
      body: ListView(
        children: [
          generarCard(size, Colors.red),
          generarCard(size, Colors.blue),
          generarCard(size, Colors.yellow),
          generarCard(size, Colors.green)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 400,
                  color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                      Text("Subir Publicacion"),
                      Text("Descripcion"),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: "Ingrese una descripcion"),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget generarCard(Size size, Color color) {
    return Container(
      width: size.width * 0.2,
      height: size.height * 0.3,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/9802281/pexels-photo-9802281.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
              ),
              SizedBox(
                width: 10,
              ),
              Text("Ozel"),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_sharp))
            ],
          ),
          Text("Here go wherever i go"),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width * 1,
            height: size.height * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.pexels.com/photos/9808579/pexels-photo-9808579.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
          )
        ],
      ),
    );
  }

  void loadKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      key = prefs.getString('key');
    });
  }
}
