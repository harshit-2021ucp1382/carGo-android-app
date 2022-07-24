import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable/drawer2.dart';

class whislist extends StatefulWidget {
  whislist({Key? key}) : super(key: key);

  @override
  State<whislist> createState() => _whislistState();
}

class _whislistState extends State<whislist> {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = "";
  late cardData data;
  @override
  void initState() {
    super.initState();
    uid = user!.uid.toString();
    whislist();
    setState(() {});
  }

  List<Object> _whislistcars = [];
  Future whislist() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("whislist")
        .get();
    setState(() {
      _whislistcars =
          List.from(data.docs.map((doc) => cardData.datastore(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Wishlist")),
      drawer: MyDrawer(curr_page: "Your Wishlist"),
      body: SafeArea(
          child: ListView.builder(
              itemCount: _whislistcars.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    MyCard(data: _whislistcars[index] as cardData),
                    Material(
                      elevation: 5,
                      // borderRadius: BorderRadius.circular(30),
                      color: Colors.redAccent,
                      child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {},
                          child: Text(
                            "Book Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ));
              })),
    );
  }
}
