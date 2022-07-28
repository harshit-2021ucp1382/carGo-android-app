import 'dart:ffi';

import 'package:cargo/Login-page/login_screen.dart';
import 'package:cargo/model/admin_model.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'dart:ffi';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class carDetails extends StatefulWidget {
  cardData data;
  carDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<carDetails> createState() => _carDetailsState();
}

class _carDetailsState extends State<carDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  AdminModel carAdmin = AdminModel();
  String name = "Name:";

  late bool logged = false;
  late cardData data;

  getuser() async {
    var info = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    logged = info.exists;
  }

  // @override
  // getAdmin() async {
  //   var user =
  //       await FirebaseFirestore.instance.collection("admins").doc(ad_id).get();
  // }

  @override
  void initState() {
    super.initState();
    getuser();
    data = widget.data;

    FirebaseFirestore.instance
        .collection("admins")
        .doc(data.adid)
        .get()
        .then((value) {
      this.carAdmin = AdminModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Car Details")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Color.fromARGB(255, 228, 220, 220),
              shadowColor: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data.image.toString()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "${widget.data.carModel.toString()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              //Text(data["Details"]),
                            ],
                          ),
                          Text("${widget.data.Rating.toString()}/5 stars"),
                          ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Text(widget.data.Price.toString()),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ])),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.black38.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        onPressed: () => {},
                        icon: Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Chat with Admin',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Features",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "1. Mileage : 15km/L ",
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )),
            SizedBox(
              height: 30,
            ),
            QrImage(
              data: "$name${carAdmin.firstName}",
              version: QrVersions.auto,
              size: 200,
              gapless: false,
              embeddedImage: NetworkImage(data.image.toString()),
              embeddedImageStyle:
                  QrEmbeddedImageStyle(color: Colors.transparent),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
              child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (logged)
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(user?.uid)
                          .collection("booked")
                          .doc(data.carID)
                          .set(data.toJson());
                    else {
                      Fluttertoast.showToast(msg: ("Not logged in as User"));
                    }
                  },
                  child: Text(
                    "Rent Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
