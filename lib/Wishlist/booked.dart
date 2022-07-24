import 'package:flutter/material.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable/drawer2.dart';

class booked extends StatefulWidget {
  booked({Key? key}) : super(key: key);

  @override
  State<booked> createState() => _bookedState();
}

class _bookedState extends State<booked> {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = "";
  late cardData data;
  @override
  void initState() {
    super.initState();
    uid = user!.uid.toString();
    booked();
    setState(() {});
  }

  List<Object> _bookedcars = [];
  Future booked() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("booked")
        .get();
    setState(() {
      _bookedcars = List.from(data.docs.map((doc) => cardData.datastore(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booked Cars")),
      drawer: MyDrawer(curr_page: "Booked Cars"),
      body: SafeArea(
          child: ListView.builder(
              itemCount: _bookedcars.length,
              itemBuilder: (BuildContext context, int index) {
                return MyCard(data: _bookedcars[index] as cardData);
              })),
    );
  }
}
