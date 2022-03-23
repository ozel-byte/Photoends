import 'dart:io';

import 'package:flutter/material.dart';
import 'package:robbin/src/service/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:file_picker/file_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? key = "";
  String? profileImg = "";
  SharedPreferences? shared;
  double validReadPublicacion = 450;
  String? _image;
  @override
  void initState() {
    super.initState();
    loadKey();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Api ap = Api();
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
                  backgroundImage: NetworkImage(profileImg!),
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
      body: RefreshIndicator(
        child: FutureBuilder(
          future: ap.getImg(key),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return generarCard(size, Colors.white, snapshot.data![index]);
                },
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
        onRefresh: onRefresh,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'subirpost');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget generarCard(Size size, Color color, photo) {
    return Container(
      width: size.width * 0.2,
      height: size.height * 0.35,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(profileImg!),
              ),
              SizedBox(
                width: 10,
              ),
              Text("Ozel"),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_sharp))
            ],
          ),
          Divider(),
          Container(
            width: size.width * 1,
            height: size.height * 0.25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain, image: NetworkImage(photo['photo']))),
          ),
          Divider()
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
      profileImg = prefs.getString("profile");
    });
  }

  void loadingImgUserNew() {
    Api().getImg(key);
  }

  Future<void> onRefresh() async {
    loadKey();
    setState(() {});
  }
}
