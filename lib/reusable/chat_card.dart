import 'package:cargo/chat/chatlobby.dart';
import 'package:cargo/model/admin_model.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String toid = '';
  String currid = 'hgCXgdi0ZvhWrijQrA10Kw9IVvs2';
  String toUser = '';
  @override
  getUserModel() async {
    print("888888888");
    print(widget.data);
    print(widget.type);
    if (widget.type == "admins") {
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.data)
          .get();
      print("user card");
      if (data != null) {
        user = UserModel();
        user = UserModel.fromMap(data.data());
      }

      print(user.firstName);
    }
    if (widget.type == "users") {
      var data = await FirebaseFirestore.instance
          .collection("admins")
          .doc(widget.data)
          .get();
      print("admin card");
      user = AdminModel();
      user = AdminModel.fromMap(data.data());
    }
    if (user != null) {
      if (widget.type == 'admins') toUser = 'users';
      if (widget.type == 'users') toUser = 'admins';
    }

    setState(() {});
  }

  @override
  void initState() {
    print("888888888");
    print(widget.data);
    getUserModel();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Text("${user?.firstName}"),
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chatLobby(
                          currId: [currid, widget.type],
                          toid: [widget.data, toUser],
                        )));
          },
          icon: Icon(
            Icons.person,
            size: 40,
          ),
        )
      ]),
    );
  }
}
