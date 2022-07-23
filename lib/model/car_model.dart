class CarModel {
  String? carID;
  String? carModel;
  String? carNumber;

  String? distance;
  String? seats;
  String? dop;

  // String? Price;
  // String? Rating;
  CarModel(
      {this.carID,
      this.carModel,
      this.carNumber,
      this.distance,
      this.seats,
      this.dop});
  factory CarModel.fromMap(map) {
    return CarModel(
      carID: map['carID'],
      carModel: map['carModel'],
      carNumber: map['carNumber'],
      distance: map['distance'],
      seats: map['seats'],
      dop: map['dop'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'carID': carID,
      'carModel': carModel,
      'carNumber': carNumber,
      'distance': distance,
      'seats': seats,
      'dop': dop,
    };
  }
}
