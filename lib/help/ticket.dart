import 'package:cargo/reusable/drawer.dart';
import 'package:flutter/material.dart';

class ticket extends StatefulWidget {
  ticket({Key? key}) : super(key: key);

  @override
  State<ticket> createState() => _ticketState();
}

class _ticketState extends State<ticket> {
  final TextEditingController _subject = new TextEditingController();
  final TextEditingController _description = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 207, 58, 233),
              Color.fromARGB(255, 0, 94, 255)
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Ticket",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color.fromARGB(255, 90, 67, 218),
              automaticallyImplyLeading: true,
            ),
            drawer: MyDarwer(data: null, curr_page: "Contact Us"),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Text("Subject",
                      style: TextStyle(
                          color: Color.fromARGB(255, 20, 19, 19),
                          fontSize: 25)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        autofocus: false,
                        controller: _subject,
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (value) {
                          _subject.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Subject",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                  ),
                  SizedBox(height: 30),
                  Text("Description",
                      style: TextStyle(
                          color: Color.fromARGB(255, 20, 19, 19),
                          fontSize: 25)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        maxLines: 10,
                        controller: _description,
                        onSubmitted: (value) {
                          _subject.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          hintText: "Descripton",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.redAccent,
                      child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {},
                          child: Text(
                            "Post",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            )));
  }
}
