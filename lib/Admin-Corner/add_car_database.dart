import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> addCarDB(String id, String model, String number, String dop,
    String seat, String dist) async {
  try {
    //String uid = FirebaseAuth.instance.currentUser!.uid;
    String uid = 'hgCXgdi0ZvhWrijQrA10Kw9IVvs2';
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('admins')
        .doc(uid)
        .collection('cars')
        .doc(id);
    int seats = int.parse(seat);
    int distance = int.parse(dist);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.get(documentReference);
      documentReference.set({
        'CarId': id,
        'CarModel': model,
        'CarNumber': number,
        'DOP': dop,
        'Seats': seats,
        'Distance': distance,
      });
      return true;
    });
    return false;
  } catch (e) {
    return false;
  }
}
