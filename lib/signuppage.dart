import 'package:cargo/home.dart';
import 'package:cargo/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reusable_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 207, 58, 233),
            Color.fromARGB(255, 0, 94, 255)
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(0, 178, 50, 50),
            title: const Text("Sign Up"),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(20, 50, 20, 0)),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Username", Icons.person_outline, false,
                  _usernameTextController),
              SizedBox(
                height: 30,
              ),
              reusableTextField("Enter Email", Icons.person_outline, false,
                  _emailTextController),
              SizedBox(
                height: 30,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              SizedBox(
                height: 30,
              ),
              firebaseButton(context, "Sign Up", () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  print("Created New Account Successfully");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => home()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              })
            ],
          )),
    );
  }
}
