import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable/drawer.dart';

class contactUs extends StatelessWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conatct Us")),
      drawer: MyDrawer(currPage: "Contact Us"),
    );
  }
}
