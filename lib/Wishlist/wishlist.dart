import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable/drawer.dart';

class wishlist extends StatelessWidget {
  const wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Wishlist")),
      drawer: MyDarwer(curr_page: "Your Wishlist"),
    );
  }
}
