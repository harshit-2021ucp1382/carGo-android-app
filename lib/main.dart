import 'package:cargo/Admin-Corner/add_car.dart';
import 'package:cargo/Admin-Corner/adminCorner.dart';
import 'package:cargo/Home/Home.dart';
import 'package:cargo/Home/home_screen.dart';
import 'package:cargo/forms/register_car.dart';
import 'package:cargo/reusable/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//import 'Login-page/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'Email And Password Login',
    theme: ThemeData(
      primarySwatch: blue,
    ),
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
