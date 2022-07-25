import 'package:cargo/Home/car_details.dart';
import 'package:cargo/Home/home_screen.dart';
import 'package:cargo/Wishlist/wishlist.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatefulWidget {
  const MyCard({Key? key, required this.data}) : super(key: key);

  final cardData data;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  User? user = FirebaseAuth.instance.currentUser;
  String? uid = "";
  Icon bookmar = Icon(Icons.bookmark_add_outlined);
  late cardData data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    uid = user?.uid.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Colors.black.withOpacity(0.04),
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data.image.toString()),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        try {
                          var exist = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid)
                              .collection("whislist")
                              .doc(data.carID)
                              .get();
                          if (!exist.exists) {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .collection("whislist")
                                .doc(data.carID)
                                .update(data.toJson());
                            Fluttertoast.showToast(
                                msg: "Car Added to Whislist");
                            bookmar = Icon(Icons.bookmark);
                          } else {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .collection("whislist")
                                .doc(data.carID)
                                .delete();
                            Fluttertoast.showToast(
                                msg: "Car Removed From Whislist");
                            bookmar = Icon(Icons.bookmark_add_outlined);
                          }
                          setState(() {});
                        } catch (e) {
                          Fluttertoast.showToast(msg: "Not logged in as User");
                          setState(() {});
                        }
                      },
                      icon: bookmar),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        "${widget.data.carModel.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.data.seats.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Color.fromARGB(255, 87, 83, 83),
                            ),
                          ),
                          Text("  | Diesel",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Color.fromARGB(255, 71, 68, 68),
                              ))
                        ],
                      )
                      //Text(data["Details"]),
                    ],
                  ),
                  Text("${widget.data.Rating.toString()}/5 stars"),
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 32, 29, 29)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Text("\u{20B9} ${widget.data.Price.toString()}/Km",
                                style: GoogleFonts.alatsi(
                                    color: Colors.white, fontSize: 18)),
                            SizedBox(
                              width: 1,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => carDetails(
                                            data: data as cardData)));
                              },
                              icon: const Icon(Icons.arrow_forward_ios_sharp),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
