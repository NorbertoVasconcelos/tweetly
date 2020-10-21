import 'package:cloud_firestore/cloud_firestore.dart';

class Tweet {
  String id;
  String text;
  DateTime creationDate;
  String user;
  List<String> likes;
  int numLikes;

  Tweet(
      {this.id,
      this.text,
      this.creationDate,
      this.user,
      this.likes,
      this.numLikes});

  Tweet.fromDocumentSnapshot(DocumentSnapshot document)
      : id = document.reference.id,
        text = document['text'],
        creationDate = document['creationDate'].toDate(),
        user = (document['user'] as DocumentReference).id,
        likes = (document['likes']).map<String>((e) {
          return (e as DocumentReference).id;
        }).toList(),
        numLikes = (document['likes'] as List<dynamic>).length;
}
