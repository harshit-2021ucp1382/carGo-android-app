import 'package:cargo/help/help.dart';
import 'package:flutter/material.dart';
import 'package:cargo/Login-page/login_screen.dart';
import '../Admin-Corner/adminCorner.dart';
import '../Contact-us/contactUs.dart';
import '../Home/home_screen.dart';
import '../Wishlist/wishlist.dart';
import "color.dart";

final String role = "admin";

class MyDarwer extends StatelessWidget {
  const MyDarwer({Key? key, required this.data, required this.curr_page})
      : super(key: key);

  final Object? data;
  final String curr_page;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
        data != null
            ? UserAccountsDrawerHeader(
                accountName: Text("Name from server"),
                accountEmail: Text("Mail from Server"),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("#")), //Image from Server
              )
            : DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      "Please Login/Signup to continue",
                      style: TextStyle(color: white),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.verified_user),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Login/Sign-up >",
                              style: TextStyle(color: white),
                            ),
                          ],
                        ))
                  ],
                ),
                decoration: BoxDecoration(color: blue),
              ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (curr_page == "Home") ? grey : white,
          onTap: (curr_page == "Home")
              ? () {}
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
        ),
        SizedBox(
          height: 10,
        ),
        data != null && role == "admin"
            ? ListTile(
                leading: Icon(Icons.car_rental),
                title: Text("Admin's Corner"),
                trailing: Icon(Icons.arrow_right),
                tileColor: (curr_page == "Admin's Corner") ? grey : white,
                onTap: (curr_page == "Admin's Corner")
                    ? () {}
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const adminCorner()));
                      },
              )
            : SizedBox(
                height: 0,
              ),
        data != null && role == "admin"
            ? SizedBox(
                height: 10,
              )
            : SizedBox(
                height: 0,
              ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text("Your Wishlist"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (curr_page == "Your Wishlist") ? grey : white,
          onTap: (curr_page == "Your Wishlist")
              ? () {}
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const wishlist()));
                },
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.headphones),
          title: Text("Contact Us"),
          trailing: Icon(Icons.arrow_right),
          tileColor: (curr_page == "Contact Us") ? grey : white,
          onTap: (curr_page == "Conatct Us")
              ? () {}
              : () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => help()));
                },
        ),
      ]),
    );
  }
}
