class AdminModel {
  String? adid;
  String? email;
  String? firstName;
  String? secondName;
  String? mobNumber;

  AdminModel(
      {this.adid, this.email, this.firstName, this.secondName, this.mobNumber});

  // receiving data from server
  factory AdminModel.fromMap(map) {
    return AdminModel(
      adid: map['adid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      mobNumber: map['mobNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'adid': adid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'mobNumber': mobNumber,
    };
  }
}
