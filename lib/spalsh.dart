import 'package:cargo/reusable/color.dart';
import 'package:flutter/material.dart';

import 'Home/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _navigate() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Container(
          color: white,
          child: Image(image: AssetImage("assets/img/icon.png")),
        ),
      ),
    );
  }
}
