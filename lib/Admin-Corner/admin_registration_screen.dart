import 'package:cargo/Admin-Corner/adminCorner.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cargo/model/admin_model.dart';
import 'package:flutter/services.dart';

class AdminRegScreen extends StatefulWidget {
  const AdminRegScreen({Key? key}) : super(key: key);

  @override
  State<AdminRegScreen> createState() => _AdminRegScreenState();
}

class _AdminRegScreenState extends State<AdminRegScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final _firstNameEditingController = new TextEditingController();
  final _secondNameEditingController = new TextEditingController();
  final _emailEditingController = new TextEditingController();
  final _passwordEditingController = new TextEditingController();
  final _confirmPasswordEditingController = new TextEditingController();
  final _phoneNumberEditingController = new TextEditingController();
  final _adhaarNumberEditingController = TextEditingController();
  final _upiIdEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        autofocus: false,
        controller: _firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          _firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: _secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          _secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final mobNumberField = TextFormField(
        autofocus: false,
        controller: _phoneNumberEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your mobile number");
          } else if (value.length != 10) {
            return ("Please enter 10 digit mobile number");
          }
          // reg expression for email validation
          if (!RegExp(r'[0-9]').hasMatch(value)) {
            return ("Please Enter a valid mobile number");
          }
          return null;
        },
        onSaved: (value) {
          _phoneNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_iphone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mobile Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final adhaarNumberField = TextFormField(
        autofocus: false,
        controller: _adhaarNumberEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your adhaar number");
          } else if (value.length != 12) {
            return ("Please enter 12 digit Adhaar number");
          }
          // reg expression for email validation
          if (!RegExp(r'[0-9]').hasMatch(value)) {
            return ("Please Enter a valid Adhaar number");
          }
          return null;
        },
        onSaved: (value) {
          _adhaarNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.contacts),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Adhaar Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: _emailEditingController,
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
          _emailEditingController.text = value!;
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

    final upiIdNumberField = TextFormField(
        autofocus: false,
        controller: _upiIdEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your UPI id");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid upi Id");
          }
          return null;
        },
        onSaved: (value) {
          _upiIdEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_balance),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "UPI Id",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: _passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          _passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: _confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (_confirmPasswordEditingController.text !=
              _passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          _confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(
                _emailEditingController.text, _passwordEditingController.text);
          },
          child: Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

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
            title: const Text("Register as a Admin"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.red),
              onPressed: () {
                // passing this to our root
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 25),
                        firstNameField,
                        const SizedBox(height: 20),
                        secondNameField,
                        const SizedBox(height: 20),
                        mobNumberField,
                        const SizedBox(height: 20),
                        emailField,
                        const SizedBox(height: 20),
                        adhaarNumberField,
                        const SizedBox(
                          height: 20,
                        ),
                        upiIdNumberField,
                        const SizedBox(
                          height: 20,
                        ),
                        passwordField,
                        const SizedBox(height: 20),
                        confirmPasswordField,
                        const SizedBox(height: 20),
                        signUpButton,
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "admin-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "admin-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our admin model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? admin = _auth.currentUser;

    AdminModel adminModel = AdminModel();

    // writing all the values
    adminModel.email = admin!.email;
    adminModel.mobNumber = _phoneNumberEditingController.text;
    adminModel.upiId = _upiIdEditingController.text;
    adminModel.adhaarNumber = _adhaarNumberEditingController.text;

    adminModel.adid = admin.uid;
    adminModel.firstName = _firstNameEditingController.text;
    adminModel.secondName = _secondNameEditingController.text;

    await firebaseFirestore
        .collection("admins")
        .doc(adminModel.adid)
        .set(adminModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => AdminCorner()),
        (route) => false);
  }
}
