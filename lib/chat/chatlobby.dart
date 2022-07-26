import 'package:cargo/model/admin_model.dart';
import 'package:cargo/model/car_model.dart';
import 'package:cargo/model/message.dart';
import 'package:cargo/reusable/chat_card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cargo/reusable/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '';
import '../model/user_model.dart';

class chatLobby extends StatefulWidget {
  List currId;
  List toid;
  String carModel;
  chatLobby(
      {Key? key,
      required this.currId,
      required this.toid,
      required this.carModel})
      : super(key: key);

  @override
  State<chatLobby> createState() => _chatLobbyState();
}

class _chatLobbyState extends State<chatLobby> {
  List<chatElement> chats = [];
  String toName = '';
  TextEditingController _send = TextEditingController();

  @override
  getChats() async {
    print(widget.currId[1]);
    print(widget.currId[0]);
    var data = await FirebaseFirestore.instance
        .collection(widget.currId[1])
        .doc(widget.currId[0])
        .collection("chats")
        .doc(widget.toid[0])
        .collection("history")
        .orderBy("timestamp")
        .get();
    chats = List.from(data.docs.map((doc) => chatElement.store(doc)));
    print(chats.length);
    var data1 = await FirebaseFirestore.instance
        .collection(widget.toid[1])
        .doc(widget.toid[0])
        .get();
    if (widget.toid[1] == "admins")
      toName = AdminModel.fromMap(data1).firstName.toString();
    if (widget.toid[1] == "users")
      toName = UserModel.fromMap(data1).firstName.toString();
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  listner() async {
    FirebaseFirestore.instance
        .collection(widget.currId[1])
        .doc(widget.currId[0])
        .collection("chats")
        .doc(widget.toid[0])
        .collection("history")
        .snapshots()
        .listen((event) {
      getChats();
    });
  }

  sendChat(String text) async {
    chatElement newchat = chatElement();
    newchat.content = text;
    newchat.from = widget.currId[0];
    newchat.to = widget.toid[0];
    newchat.timestamp = Timestamp.now();
    var exist = await FirebaseFirestore.instance
        .collection(widget.currId[1])
        .doc(widget.currId[0])
        .collection("chats")
        .doc(widget.toid[0])
        .get();
    if (!exist.exists) {
      await FirebaseFirestore.instance
          .collection(widget.currId[1])
          .doc(widget.currId[0])
          .collection("chats")
          .doc(widget.toid[0])
          .set({"uid": "uid"});
    }
    await FirebaseFirestore.instance
        .collection(widget.currId[1])
        .doc(widget.currId[0])
        .collection("chats")
        .doc(widget.toid[0])
        .collection("history")
        .add(newchat.toJson());

    var exist1 = await FirebaseFirestore.instance
        .collection(widget.toid[1])
        .doc(widget.toid[0])
        .collection("chats")
        .doc(widget.currId[0])
        .get();
    if (!exist1.exists) {
      await FirebaseFirestore.instance
          .collection(widget.toid[1])
          .doc(widget.toid[0])
          .collection("chats")
          .doc(widget.currId[0])
          .set({"uid": "uid"});
    }
    await FirebaseFirestore.instance
        .collection(widget.toid[1])
        .doc(widget.toid[0])
        .collection("chats")
        .doc(widget.currId[0])
        .collection("history")
        .add(newchat.toJson());
  }

  @override
  void initState() {
    getChats();
    listner();
    reference();
    setState(() {});
  }

  void reference() {
    if (widget.carModel != "false") {
      sendChat("With Refernce to the car" + widget.carModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chat Room")),
        drawer: const MyDrawer(currPage: "Chat Lobby"),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                toName,
                style: TextStyle(fontSize: 20, color: grey),
              ),
              SafeArea(
                  child: ListView.builder(
                      shrinkWrap: true,
                      key: UniqueKey(),
                      itemCount: chats.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: chats[index].from == widget.currId[0]
                                  ? grey
                                  : Color.fromARGB(255, 105, 126, 136)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Align(
                            alignment: chats[index].from == widget.currId[0]
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                                child: Text(
                              chats[index].content.toString(),
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                        );
                      })),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _send,
                      decoration: InputDecoration(hintText: "Send text"),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (_send.text != null) {
                          sendChat(_send.text);
                        }
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ],
          ),
        )));
    ;
  }
}
