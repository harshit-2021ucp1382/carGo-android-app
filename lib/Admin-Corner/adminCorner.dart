import 'package:cargo/Admin-Corner/add_car.dart';
import 'package:cargo/Admin-Corner/admin_login_screen.dart';
import 'package:cargo/Login-page/login_screen.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable/drawer.dart';

class AdminCorner extends StatefulWidget {
  const AdminCorner({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminCorner> createState() => _AdminCornerState();
}

class _AdminCornerState extends State<AdminCorner> {
  String? adid = FirebaseAuth.instance.currentUser?.uid;
  List<Object> _cars = [];

  Future getCars() async {
    var data = await FirebaseFirestore.instance
        .collection("admins")
        .doc(adid)
        .collection("cars")
        .get();
    setState(() {
      _cars = List.from(data.docs.map((doc) => cardData.datastore(doc)));
    });
  }

  @override
  void initState() {
    super.initState();
    getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin's Corner")),
      drawer: const MyDarwer(
        curr_page: "Admin's Corner",
      ),
      body: (FirebaseAuth.instance.currentUser != null)
          ? Container(
              decoration: BoxDecoration(color: white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SafeArea(
                    child: ListView.builder(
                        itemCount: _cars.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MyCard(data: _cars[index] as cardData);
                        })),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AdminLoginPage())));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.login),
                      SizedBox(width: 5),
                      Text("Login to continue"),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const AddCar())));
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
