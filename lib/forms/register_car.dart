import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class add_car extends StatefulWidget {
  add_car({Key? key}) : super(key: key);

  @override
  State<add_car> createState() => _add_carState();
}

class _add_carState extends State<add_car> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final model = new TextEditingController();
  final car_number = new TextEditingController();
  final dop = new TextEditingController();
  final seats = new TextEditingController();
  final distance = new TextEditingController();

  final modelField = TextFormField(
      autofocus: false,
      //controller: model,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Invalid Model Number");
        }
        return null;
      },
      onSaved: (value) {
        //model.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.info),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Model Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
  final number_field = TextFormField(
      autofocus: false,
      //controller: model,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Invalid Car Number");
        }
        return null;
      },
      onSaved: (value) {
        //model.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.info),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Car Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

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
          body: Center(
              child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                modelField,
                                SizedBox(
                                  height: 30,
                                ),
                                number_field,
                              ])))))),
    );
  }
}
