import 'package:cargo/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reusable_widget.dart';
import 'package:flutter/material.dart';

class ResetPwd extends StatefulWidget {
  const ResetPwd({Key? key}) : super(key: key);

  @override
  State<ResetPwd> createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  final TextEditingController _emailTextController = TextEditingController();

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
            backgroundColor: const Color.fromARGB(0, 178, 50, 50),
            title: const Text("Reset Password"),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.fromLTRB(20, 50, 20, 0)),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Email", Icons.person_outline, false,
                  _emailTextController),
              const SizedBox(
                height: 15,
              ),
              firebaseButton(context, "Reset", () {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _emailTextController.text);
              })
            ],
          )),
    );
  }
}
