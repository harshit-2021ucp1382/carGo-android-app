import 'package:flutter/material.dart';
import 'package:cargo/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminResetPwd extends StatefulWidget {
  const AdminResetPwd({Key? key}) : super(key: key);

  @override
  State<AdminResetPwd> createState() => _AdminResetPwdState();
}

class _AdminResetPwdState extends State<AdminResetPwd> {
  final TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
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
              emailField,
              const SizedBox(
                height: 15,
              ),
              firebaseButton(context, "Reset", () {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _emailController.text);
              })
            ],
          )),
    );
  }
}
