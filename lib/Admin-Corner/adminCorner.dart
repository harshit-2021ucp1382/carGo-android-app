import 'package:flutter/material.dart';

import '../reusable/drawer.dart';

class adminCorner extends StatelessWidget {
  const adminCorner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin's Corner")),
      drawer: MyDarwer(data: null, curr_page: "Admin's Corner"),
    );
  }
}