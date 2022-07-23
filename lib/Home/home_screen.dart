import 'package:cargo/Home/filter.dart';
import 'package:cargo/Home/search.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cargo/reusable/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cargo/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import '../Login-page/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  cardData card = cardData();
  List<Object> _cars = [];
  Future getCars() async {
    var data = await FirebaseFirestore.instance.collection("cars").get();
    setState(() {
      _cars = List.from(data.docs.map((doc) => cardData.datastore(doc)));
    });
  }

  @override
  void initState() {
    super.initState();
    getCars();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    if (loggedInUser != null)
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                      print(result);
                    },
                    icon: const Icon(Icons.sort))
              ],
            ),
            drawer: MyDarwer(curr_page: "Home"),
            body: SafeArea(
                child: ListView.builder(
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
