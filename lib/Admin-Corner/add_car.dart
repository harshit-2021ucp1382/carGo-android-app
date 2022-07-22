import 'dart:io';
import 'package:cargo/Admin-Corner/add_car_database.dart';
import 'package:cargo/reusable/color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _numberController = TextEditingController();
  final _dopController = TextEditingController();
  final _seatsController = TextEditingController();
  final _distController = TextEditingController();
  // late Future<String> _coverImg;
  // late Future<List<String>> _otherImg;
  // late Future<String> _puc;
  // late Future<String> _reg;
  // late Future<String> _insurance;
  var uuid = const Uuid().v1();

  // FirebaseStorage storage = FirebaseStorage.instance;
  // Future<String> getFile(String name) async {
  //   //String? uid = FirebaseAuth.instance.currentUser?.uid;
  //   String uid = 'hgCXgdi0ZvhWrijQrA10Kw9IVvs2';
  //   File file;
  //   String path =
  //       "gs://cargo-android.appspot.com/car_images/${uid}/${uuid}/${name}";
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(type: FileType.any);
  //   if (result != null) {
  //     file = File(result.files.single.path!);
  //     try {
  //       await storage.ref(path).putFile(file);
  //       setState(() {});
  //       return path;
  //     } on FirebaseException catch (e) {
  //       print(e);
  //       return "\0";
  //     }
  //   } else
  //     return "\0";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your Car"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _modelController,
                    decoration: InputDecoration(
                      hintText: "................",
                      hintStyle: TextStyle(
                        color: grey,
                      ),
                      labelText: "Car Model",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _numberController,
                    decoration: InputDecoration(
                      hintText: "XX99XX9999",
                      hintStyle: TextStyle(
                        color: grey,
                      ),
                      labelText: "Car Number",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dopController,
                    decoration: InputDecoration(
                      hintText: "mm.dd.yyyy",
                      hintStyle: TextStyle(
                        color: grey,
                      ),
                      labelText: "Date of Purchase",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _seatsController,
                    decoration: InputDecoration(
                      hintText: "9",
                      hintStyle: TextStyle(
                        color: grey,
                      ),
                      labelText: "Number of Seats",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _distController,
                    decoration: InputDecoration(
                      hintText: "99999",
                      hintStyle: TextStyle(
                        color: grey,
                      ),
                      labelText: "Distance Travelled",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Text(
                        "Cover Image",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          //_coverImg = getFile("coverPhoto");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.upload),
                            SizedBox(width: 5),
                            Text("Upload")
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        "Other Images",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          //getFile("otherImage");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.upload),
                            SizedBox(width: 5),
                            Text("Upload")
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        "PUC Certificate",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          //_puc = getFile("puc");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.upload),
                            SizedBox(width: 5),
                            Text("Upload")
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        "Registration",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // _reg = getFile("regCertificate");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.upload),
                            SizedBox(width: 5),
                            Text("Upload")
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        "Insurance",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // _insurance = getFile("insurance");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.upload),
                            SizedBox(width: 5),
                            Text("Upload")
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      addCarDB(
                        uuid,
                        _modelController.text,
                        _numberController.text,
                        _dopController.text,
                        _seatsController.text,
                        _distController.text,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.app_registration_rounded),
                        SizedBox(width: 5),
                        Text("Add the Car")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
