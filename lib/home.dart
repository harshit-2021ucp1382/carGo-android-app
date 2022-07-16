import 'package:cargo/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
          Container(
              height: 20,
              width: 200,
              child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search Location", icon: Icon(Icons.search)))),
        ]),
        SizedBox(
          height: 600,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.amber,
                child: Icon(Icons.sort))),
        Container(
          child: ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              });
            },
          ),
        ),
      ]),
    );
  }
}
