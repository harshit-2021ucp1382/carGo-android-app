import 'dart:io';
import 'package:cargo/Admin-Corner/add_car_database.dart';
import 'package:cargo/model/admin_model.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _priceController = TextEditingController();
  final _typeController = TextEditingController();
  User? admin = FirebaseAuth.instance.currentUser;
  AdminModel loggedInAdmin = AdminModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("admins")
        .doc(loggedInAdmin.adid)
        .get()
        .then((value) {
      this.loggedInAdmin = AdminModel.fromMap(value.data());
      setState(() {});
    });
  }

  late String carId;
  PlatformFile? _coverfile;
  PlatformFile? _insurance;
  PlatformFile? _puc;
  PlatformFile? _reg;
  late String path_insurance = '';
  late String path_img = '';
  late String path_puc = '';
  late String path_reg = '';
  List<String> Urls = [];
  Future coverimg() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
    if (result == null) return;
    setState(() {
      _coverfile = result.files.first;
    });
  }

  Future insurance() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return;
    setState(() {
      _insurance = result.files.first;
    });
  }

  Future puc() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return;
    setState(() {
      _puc = result.files.first;
    });
  }

  Future reg() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return;
    setState(() {
      _reg = result.files.first;
    });
  }

  Future<String> upload(String path, PlatformFile? file, String item) async {
    if (file != null) {
      final f = File(file.path!);
      final ref = await FirebaseStorage.instance.ref().child(path);
      var uploadTask = ref.putFile(f);

      final snap = await uploadTask.whenComplete(() {});
      final url = await snap.ref.getDownloadURL();
      return Future.value(url.toString());
    } else {
      return "error";
    }
  }

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
                    controller: _priceController,
                    decoration: InputDecoration(
                      hintText: "200",
                      hintStyle: TextStyle(
                        color: grey,
                      ),
                      labelText: "Price",
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
                          coverimg();
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
                          puc();
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
                          reg();
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
                          insurance();
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
                    onPressed: () async {
                      cardData car = cardData();
                      car.carModel = _modelController.text;
                      car.adid = loggedInAdmin.adid;
                      car.carNumber = _numberController.text;
                      car.distance = _distController.text;
                      car.seats = _seatsController.text;
                      car.dop = _dopController.text;
                      car.type = "null";
                      await FirebaseFirestore.instance
                          .collection("cars")
                          .add(car.toJson())
                          .then((value) {
                        carId = value.id;
                      });
                      car.carID = carId;
                      car.Rating = "0 Stars";
                      car.Price = _priceController.text;

                      car.image = await upload(
                          "cars_data/" + carId + "/cover", _coverfile, "image");
                      print(path_img);
                      car.puc = await upload(
                          "cars_data/" + carId + "/puc", _puc, "puc");
                      car.registration = await upload(
                          "cars_data/" + carId + "/reg", _reg, "reg");
                      ;
                      car.insurance = await upload(
                          "cars_data/" + carId + "/insurance",
                          _insurance,
                          "insurance");
                      ;
                      await FirebaseFirestore.instance
                          .collection("cars")
                          .doc(carId)
                          .update(car.toJson());
                      await FirebaseFirestore.instance
                          .collection("admins")
                          .doc(loggedInAdmin.adid)
                          .collection("cars")
                          .doc(carId)
                          .set(car.toJson());
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
