import 'package:cargo/Admin-Corner/add_car.dart';
import 'package:cargo/Admin-Corner/admin_login_screen.dart';
import 'package:cargo/Login-page/login_screen.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cargo/model/admin_model.dart';
import '../reusable/drawer.dart';

class adminCorner extends StatefulWidget {
  const adminCorner({Key? key}) : super(key: key);

  @override
  State<adminCorner> createState() => _adminCornerState();
}

class _adminCornerState extends State<adminCorner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin's Corner")),
      drawer: MyDarwer(curr_page: "Admin's Corner"),
      body: (FirebaseAuth.instance.currentUser != null)
          ? Container(
              decoration: BoxDecoration(color: white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: StreamBuilder(
                  stream: carRef.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(title: data[index]['carModel']);
                      },
                    );
                  },
                ),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AdminLoginPage())));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.login),
                      SizedBox(width: 5),
                      Text("Login to continue"),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddCar())));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

@immutable
class Cars {
  const Cars({
    required this.otherPhotos,
    required this.seats,
    required this.coverPhoto,
    required this.carId,
    required this.dop,
    required this.carModel,
    required this.distance,
  });

  Cars.fromJson(Map<String, Object?> json)
      : this(
          otherPhotos: (json['otherPhotos']! as List).cast<String>(),
          seats: json['seats']! as int,
          coverPhoto: json['coverPhoto']! as String,
          carId: json['carId']! as String,
          dop: json['dop']! as String,
          carModel: json['carModel']! as String,
          distance: json['distance']! as int,
        );

  final String coverPhoto;
  final int seats;
  final String carModel;
  final int distance;
  final String dop;
  final String carId;
  final List<String> otherPhotos;

  Map<String, Object?> toJson() {
    return {
      'otherPhotos': otherPhotos,
      'seats': seats,
      'coverPhoto': coverPhoto,
      'carId': carId,
      'dop': dop,
      'carModel': carModel,
      'distance': distance,
    };
  }
}

final carRef = FirebaseFirestore.instance
    .collection('admins')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('cars')
    .withConverter<Cars>(
      fromFirestore: (snapshots, _) => Cars.fromJson(snapshots.data()!),
      toFirestore: (cars, _) => cars.toJson(),
    );

// class _Car extends StatelessWidget {
//   const _Car(this.vroom, this.reference);

//   final Cars vroom;
//   final DocumentReference<Cars> reference;

//   /// Returns the movie coverPhoto.
//   Widget get coverPhoto {
//     return SizedBox(
//       width: 100,
//       child: Image.network(vroom.coverPhoto),
//     );
//   }

//   /// Returns movie details.
//   Widget get details {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           carModel,
//         ],
//       ),
//     );
//   }

//   /// Return the movie carModel.
//   Widget get carModel {
//     return Text(
//       '${vroom.carModel} (${vroom.distance})',
//       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     );
//   }

//   /// Returns a list of otherPhotos movie tags.
//   List<Widget> get otherPhotosItems {
//     return [
//       for (final otherPhotos in vroom.otherPhotos) Image.network(otherPhotos),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4, top: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           coverPhoto,
//           Flexible(child: details),
//         ],
//       ),
//     );
//   }
// }