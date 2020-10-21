import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;

  User(this.id, this.name);

  User.fromSnapshot(DocumentSnapshot document)
      : id = document.reference.id,
        name = document['name'];

  User.fromMap(Map<String, dynamic> map) : name = map['name'];
}
