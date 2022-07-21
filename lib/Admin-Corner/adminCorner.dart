import 'package:cargo/reusable/card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../reusable/drawer.dart';

class adminCorner extends StatefulWidget {
  const adminCorner({Key? key}) : super(key: key);

  @override
  State<adminCorner> createState() => _adminCornerState();
}

class _adminCornerState extends State<adminCorner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin's Corner")),
      drawer: MyDarwer(data: 1, curr_page: "Admin's Corner"),
      body: Container(
        decoration: BoxDecoration(color: white),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('admins')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('cars')
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text("Fetch something"),
                    );
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Some Error occured"),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return MyCard(data: snapshot.data);
                      },
                    );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
