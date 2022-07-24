import 'package:cargo/Home/car_details.dart';
import 'package:cargo/Home/home_screen.dart';
import 'package:cargo/Wishlist/wishlist.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MyCard extends StatefulWidget {
  const MyCard({Key? key, required this.data}) : super(key: key);

  final cardData data;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {


  User? user = FirebaseAuth.instance.currentUser;
  String uid = "";
  late cardData data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    uid = user!.uid.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Image.network(
              widget.data.image.toString(),
              width: double.infinity,
            Stack(
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
                IconButton(
                    onPressed: () async {
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
                            .set(data.toJson());
                        Fluttertoast.showToast(msg: "Car Added to Whislist");
                      } else {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .collection("whislist")
                            .doc(data.carID)
                            .delete();
                        Fluttertoast.showToast(
                            msg: "Car Removed From Whislist");
                      }
                    },
                    icon: Icon(Icons.library_add)),
              ],
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
                        child: Row(
                          children: [
                            Text(widget.data.Price.toString()),
                            SizedBox(
                              width: 3,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => carDetails(
                                            data: data as cardData)));
                              },
                              icon: const Icon(Icons.arrow_forward_sharp),
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
