import 'package:cargo/Home/filter.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  UserModel({this.uid, this.email, this.firstName, this.secondName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}

class cardData {
  String? adid;
  String? carID;
  String? carModel;
  String? carNumber;
  String? image;
  String? distance;
  String? seats;
  String? dop;
  String? puc;
  String? registration;
  String? Price;
  String? Rating;
  String? insurance;
  String? type;
  String? location;
  cardData();
  Map<String, dynamic> toJson() => {
        'adid': adid,
        'carID': carID,
        'carModel': carModel,
        'carNumber': carNumber,
        'image': image,
        'distance': distance,
        "seats": seats,
        "dop": dop,
        "puc": puc,
        "registration": registration,
        "Price": Price,
        'Rating': Rating,
        'insurance': insurance,
        'type': type,
        'location': location
      };

  cardData.datastore(snapshot)
      : adid = snapshot.data()['adid'],
        carID = snapshot.data()['carID'],
        carNumber = snapshot.data()['carNumber'],
        carModel = snapshot.data()['carModel'],
        image = snapshot.data()['image'],
        distance = snapshot.data()['distance'],
        seats = snapshot.data()['seats'],
        dop = snapshot.data()['dop'],
        puc = snapshot.data()['puc'],
        registration = snapshot.data()['registraion'],
        Price = snapshot.data()['Price'],
        Rating = snapshot.data()['Rating'],
        insurance = snapshot.data()['insurance'],
        type = snapshot.data()['type'],
        location = snapshot.data()['location'];
}
