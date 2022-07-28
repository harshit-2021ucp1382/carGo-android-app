import 'package:cargo/Admin-Corner/adminCorner.dart';
import 'package:flutter/material.dart';

class Congo extends StatelessWidget {
  const Congo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Success"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Your car was successfully added",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminCorner()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle),
                  SizedBox(width: 5),
                  Text("OK"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
