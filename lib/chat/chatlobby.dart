import 'package:cargo/model/message.dart';
import 'package:cargo/reusable/chat_card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cargo/reusable/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '';

class chatLobby extends StatefulWidget {
  List currId;
  List toid;
  chatLobby({Key? key, required this.currId, required this.toid})
      : super(key: key);

  @override
  State<chatLobby> createState() => _chatLobbyState();
}

class _chatLobbyState extends State<chatLobby> {
  List<chatElement> chats = [];
  TextEditingController _send = TextEditingController();

  @override
  getChats() async {
    print(widget.currId[0]);
    print(widget.toid[0]);
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

    //print(chats[0].from);
    setState(() {});
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

  @override
  void initState() {
    getChats();
    listner();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chat Room")),
        drawer: const MyDarwer(
          curr_page: "Chat Lobby",
        ),
        body: Column(
          children: <Widget>[
            SafeArea(
                child: ListView.builder(
                    shrinkWrap: true,
                    key: UniqueKey(),
                    itemCount: chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: chats[index].from == widget.currId[0]
                                ? grey
                                : Color.fromARGB(255, 105, 126, 136)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        chatElement newchat = chatElement();
                        newchat.content = _send.text;
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
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ],
        ));
    ;
  }
}
