import 'package:cloud_firestore/cloud_firestore.dart';

class chatElement {
  String? content;
  String? to;
  String? from;
  Timestamp? timestamp;
  Map<String, dynamic> toJson() =>
      {'content': content, 'to': to, 'from': from, 'timestamp': timestamp};
  chatElement();
  chatElement.store(snapshot)
      : content = snapshot.data()['content'],
        to = snapshot.data()['to'],
        from = snapshot.data()['from'],
        timestamp = snapshot.data()['timestamp'];
}
