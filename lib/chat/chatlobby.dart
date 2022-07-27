import 'package:cargo/model/admin_model.dart';
import 'package:cargo/model/message.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cargo/reusable/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    var data = await FirebaseFirestore.instance
        .collection(widget.currId[1])
        .doc(widget.currId[0])
        .collection("chats")
        .doc(widget.toid[0])
        .collection("history")
        .orderBy("timestamp")
        .get();
    chats = List.from(data.docs.map((doc) => chatElement.store(doc)));
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
    _send.text = '';
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
      sendChat("With refernce to the car " + widget.carModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Scaffold(
          appBar: AppBar(title: const Text("Chat Room")),
          drawer: const MyDrawer(currPage: "Chat Lobby"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Text(
                      toName,
                      style: TextStyle(fontSize: 20, color: grey),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        key: UniqueKey(),
                        itemCount: chats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 100,
                            child: Container(
                              alignment: chats[index].from == widget.currId[0]
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(4),
                                  alignment:
                                      chats[index].from == widget.currId[0]
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: Text(
                                    chats[index].content.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      backgroundColor:
                                          chats[index].from == widget.currId[0]
                                              ? Colors.green
                                              : Colors.blue,
                                    ),
                                  )),
                            ),
                          );
                        }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _send,
                              decoration:
                                  InputDecoration(hintText: "Send text"),
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
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
    ;
  }
}
