import 'package:cargo/Admin-Corner/admin_login_screen.dart';
import 'package:cargo/Login-page/login_screen.dart';
import 'package:cargo/Wishlist/wishlist.dart';
import 'package:cargo/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cargo/help/help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Admin-Corner/adminCorner.dart';

import '../Home/home_screen.dart';

import "color.dart";

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key, required this.curr_page}) : super(key: key);

  final String curr_page;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
        loggedInUser.uid != null
            ? UserAccountsDrawerHeader(
                accountName: Text("${loggedInUser.firstName}"),
                accountEmail: Text("${loggedInUser.email}"),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/img/admin_avtar.png")), //Image from Server
              )
            : DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      "Please Login/Signup to continue",
                      style: TextStyle(color: white),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.verified_user),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Login/Sign-up >",
                              style: TextStyle(color: white),
                            ),
                          ],
                        ))
                  ],
                ),
                decoration: BoxDecoration(color: blue),
              ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (widget.curr_page == "Home") ? grey : white,
          onTap: (widget.curr_page == "Home")
              ? () {}
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text("Admin's Corner"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (widget.curr_page == "Admin's Corner") ? grey : white,
          onTap: (widget.curr_page == "Admin's Corner")
              ? () {}
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminCorner()));
                },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text("Your Wishlist"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (widget.curr_page == "Your Wishlist") ? grey : white,
          onTap: (widget.curr_page == "Your Wishlist")
              ? () {}
              : () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => whislist()));
                },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.headphones),
          title: Text("Contact Us"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (widget.curr_page == "Contact Us") ? grey : white,
          onTap: (widget.curr_page == "Conatct Us")
              ? () {}
              : () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => help()));
                },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.logout_rounded),
          title: Text("Logout"),
          trailing: Icon(Icons.arrow_left_rounded),
          onTap: () {
            Navigator.pop(context, true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminLoginPage()),
            );
          },
        ),
      ]),
    );
  }
}
