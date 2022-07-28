import 'package:cargo/chat/chatlobby.dart';
import 'package:cargo/model/admin_model.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatCard extends StatefulWidget {
  chatCard({Key? key, required this.data, required this.type})
      : super(key: key);
  String data;
  String type;

  @override
  State<chatCard> createState() => _chatCardState();
}

class _chatCardState extends State<chatCard> {
  dynamic user;
  String currid = FirebaseAuth.instance.currentUser!.uid.toString();
  String toid = '';
  String toUser = '';
  @override
  getUserModel() async {
    if (widget.type == "admins") {
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.data)
          .get();
      if (data != null) {
        user = UserModel();
        user = UserModel.fromMap(data.data());
      }
    }
    if (widget.type == "users") {
      var data = await FirebaseFirestore.instance
          .collection("admins")
          .doc(widget.data)
          .get();
      user = AdminModel();
      user = AdminModel.fromMap(data.data());
    }
    if (user != null) {
      if (widget.type == 'admins') toUser = 'users';
      if (widget.type == 'users') toUser = 'admins';
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getUserModel();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35,
                backgroundImage: currid[1] == 'admins'
                    ? AssetImage("assets/img/AdminAvatar.png")
                    : AssetImage("assets/img/UserAvatar.png"),
              ),
              SizedBox(width: 20),
              Text(
                "${user?.firstName}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => chatLobby(
                      currId: [currid, widget.type],
                      toid: [widget.data, toUser],
                      carModel: "false",
                    )));
      },
    );
  }
}
