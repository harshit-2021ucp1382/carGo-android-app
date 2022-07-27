import 'dart:convert';
import 'package:cargo/Home/filter.dart';
import 'package:cargo/Home/search.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cargo/reusable/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cargo/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../Login-page/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  cardData card = cardData();
  List<Object> _cars = [];
  String currLoc = "DELHI";
  List seats = [];
  List filter_rating = [];
  int _filterloc = 0;
  int _filterPrice = 0;
  Future getCars(String filter) async {
    var data;
    if (filter == "none") {
      data = await FirebaseFirestore.instance
          .collection("cars")
          .orderBy("Price")
          .get();
      setState(() {
        _cars = List.from(data.docs.map((doc) => cardData.datastore(doc)));
      });
    } else {
      _cars = [];

      if (seats.isEmpty) seats = ['1', '2', '3', '4', '5', '6', '7', '8'];
      if (filter_rating.isEmpty) filter_rating = ['0', '1', '2', '3', '4', '5'];
      if (_filterPrice == 1) {
        data = await FirebaseFirestore.instance
            .collection("cars")
            .orderBy("Price")
            .get();
      } else {
        data = await FirebaseFirestore.instance.collection("cars").get();
      }
      List<Object> _cars1 = [];
      _cars1 = List.from(data.docs.map((doc) => cardData.datastore(doc)));
      if (filter_rating.length > 0) {
        for (int i = 0; i < _cars1.length; i++) {
          if (filter_rating.contains((_cars1[i] as cardData).Rating)) {
            _cars.add(_cars1[i]);
          }
        }
      }
      _cars1 = [];
      if (seats.length > 0 && _cars.length > 0) {
        for (int i = 0; i < _cars.length; i++) {
          if (seats.contains((_cars[i] as cardData).seats)) {
            _cars1.add(_cars[i]);
          }
        }
      }
      _cars = _cars1;
      if (currLoc != null && _filterloc == 1) {
        _cars = [];

        for (int i = 0; i < _cars1.length; i++) {
          if ((_cars1[i] as cardData).location == currLoc) {
            _cars.add(_cars1[i]);
          }
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCars("none");
    //var Position = _determinePosition();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: blue,
              title: Text("Home"),
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => search())),
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () async {
                      var result = await Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) {
                        return FilterScreen();
                      }));
                      try {
                        var info = jsonDecode(result);
                        _filterPrice = info['Price'];
                        _filterloc = info['Location'];
                        seats = [];
                        filter_rating = [];
                        if (info['cat'].length > 0) {
                          for (int i = 0; i < info['cat'].length; i += 2) {
                            if (info['cat'][i][0] == 'R')
                              filter_rating.add(info['cat'][i + 1]);
                            if (info['cat'][i][0] == 'S')
                              seats.add(info['cat'][i + 1]);
                          }
                        }
                        getCars("filter");
                      } catch (e) {
                        ;
                      }

                      setState(() {});
                    },
                    icon: const Icon(Icons.sort))
              ],
            ),
            drawer: MyDrawer(currPage: "Home"),
            body: SafeArea(
                child: new ListView.builder(
                    key: UniqueKey(),
                    itemCount: _cars.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyCard(data: _cars[index] as cardData);
                    }))));
  }
}

// the logout function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
}
