import 'package:cargo/reusable/color.dart';
import 'package:cargo/spalsh.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'Email And Password Login',
    theme: ThemeData(
      primarySwatch: blue,
    ),
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));
}
