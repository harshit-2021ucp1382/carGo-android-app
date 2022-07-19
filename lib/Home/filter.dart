import 'package:flutter/material.dart';

class filter extends StatelessWidget {
  const filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        child: Text("Filter"),
      )),
    );
  }
}
