import 'package:cargo/Admin-Corner/add_car.dart';
import 'package:cargo/Admin-Corner/admin_login_screen.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/admin_model.dart';
import '../reusable/drawer.dart';

class AdminCorner extends StatefulWidget {
  const AdminCorner({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminCorner> createState() => _AdminCornerState();
}

class _AdminCornerState extends State<AdminCorner> {
  User? admin = FirebaseAuth.instance.currentUser;
  AdminModel loggedInAdmin = AdminModel();
  cardData card = cardData();
  List<Object> _admincars = [];
  User? user = FirebaseAuth.instance.currentUser;
  late bool logged_admin = false;
  late cardData data;
  getuser() async {
    var info = await FirebaseFirestore.instance
        .collection("admins")
        .doc(admin?.uid)
        .get();
    logged_admin = info.exists;
  }

  @override
  listner3() async {
    FirebaseFirestore.instance
        .collection("admins")
        .doc(admin?.uid)
        .collection("cars")
        .snapshots()
        .listen((event) {
      getCars();
      setState(() {});
    });
  }

  Future getCars() async {
    var data = await FirebaseFirestore.instance
        .collection("admins")
        .doc(admin?.uid)
        .collection("cars")
        .get();
    setState(() {
      _admincars = List.from(data.docs.map((doc) => cardData.datastore(doc)));
    });
  }

  @override
  void initState() {
    super.initState();
    getCars();
    getuser();
    FirebaseFirestore.instance
        .collection("users")
        .doc(admin?.uid)
        .get()
        .then((value) {
      this.loggedInAdmin = AdminModel.fromMap(value.data());
      listner3();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin's Corner")),
      drawer: MyDrawer(
        currPage: "Admin's Corner",
      ),
      body: (logged_admin)
          ? Container(
              decoration: BoxDecoration(color: white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SafeArea(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _admincars.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MyCard(data: _admincars[index] as cardData);
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
      floatingActionButton: (logged_admin)
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
