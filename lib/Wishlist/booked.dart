import 'package:flutter/material.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable/drawer.dart';

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
  listner2() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("booked")
        .snapshots()
        .listen((event) {
      booked();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    uid = user!.uid.toString();
    booked();
    listner2();
    setState(() {});
  }

  final _ratingController = TextEditingController();

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

  Future<void> addRating(data) async {
    double rate = double.parse(data.Rating.toString());
    int users = int.parse(data.users.toString());
    rate = (rate * users + int.parse(_ratingController.text)) / (users + 1);
    users += 1;
    data.Rating = rate.toString();
    data.users = users.toString();
    await FirebaseFirestore.instance
        .collection("cars")
        .doc(data.carID)
        .update(data.toJson());
    await FirebaseFirestore.instance
        .collection("admins")
        .doc(data.adid)
        .collection("cars")
        .doc(data.carID)
        .update(data.toJson());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("booked")
        .doc(data.carID)
        .update(data.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booked Cars")),
      drawer: MyDrawer(currPage: "Booked Cars"),
      body: SafeArea(
          child: ListView.builder(
              key: UniqueKey(),
              itemCount: _bookedcars.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    MyCard(data: _bookedcars[index] as cardData),
                    Card(
                      child: Row(
                        children: <Widget>[
                          const Text("Rate the car :"),
                          const SizedBox(width: 10),
                          SingleChildScrollView(
                            child: Form(
                              key: UniqueKey(),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 20,
                                        child: TextFormField(
                                          controller: _ratingController,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: false,
                                                  decimal: false),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text("/5"),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              addRating(_bookedcars[index] as cardData);
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
