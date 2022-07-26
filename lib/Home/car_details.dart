import 'package:cargo/Home/congra.dart';
import 'package:cargo/Login-page/login_screen.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class carDetails extends StatefulWidget {
  cardData data;
  carDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<carDetails> createState() => _carDetailsState();
}

class _carDetailsState extends State<carDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool logged = false;
  late cardData data;
  getuser() async {
    var info = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    logged = info.exists;
  }

  @override
  void initState() {
    super.initState();
    getuser();
    data = widget.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Car Details")),
      body: Center(
        child: Column(
          children: [
            Card(
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
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
              child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (logged) {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(user?.uid)
                          .collection("booked")
                          .doc(data.carID)
                          .set(data.toJson());
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Congo()));
                    } else {
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
