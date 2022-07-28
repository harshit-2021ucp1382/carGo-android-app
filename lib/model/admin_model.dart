class AdminModel {
  String? adid;
  String? email;
  String? firstName;
  String? secondName;
  String? mobNumber;
  String? upiId;
  String? adhaarNumber;

  AdminModel(
      {this.adid,
      this.email,
      this.firstName,
      this.secondName,
      this.mobNumber,
      this.upiId,
      this.adhaarNumber});

  // receiving data from server
  factory AdminModel.fromMap(map) {
    return AdminModel(
      adid: map['adid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      mobNumber: map['mobNumber'],
      upiId: map['upiId'],
      adhaarNumber: map['adhaaarNumber'],
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
      'upiId': upiId,
      'adhaarNumber': adhaarNumber
    };
  }
}
