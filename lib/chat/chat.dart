import 'package:cargo/model/message.dart';
import 'package:cargo/reusable/chat_card.dart';
import 'package:cargo/reusable/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

class chatroom extends StatefulWidget {
  chatroom({Key? key, required this.id, required this.typeuser})
      : super(key: key);
  String id;
  String typeuser;
  @override
  State<chatroom> createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  List<String> inChat = [];
  dynamic documents;

  getMarker() async {
    print("88888888888888");
    print(widget.typeuser);
    print(widget.id);
    if (widget.typeuser != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection(widget.typeuser)
          .doc(widget.id)
          .collection("chats")
          .get();

      documents = snapshot.docs;
      print(documents.length);
      if (documents.length > 0) {
        print(documents[0].id);
        print(documents[0].data());
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getMarker();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Room")),
      drawer: const MyDrawer(
        currPage: "Chat",
      ),
      body: documents != null
          ? SafeArea(
              child: ListView.builder(
                  key: UniqueKey(),
                  itemCount: documents?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return chatCard(
                      data: documents[index].id,
                      type: widget.typeuser,
                    );
                  }))
          : Container(
              child: Text('not called'),
            ),
    );
  }
}
