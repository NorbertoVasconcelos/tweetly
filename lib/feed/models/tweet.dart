import 'package:cloud_firestore/cloud_firestore.dart';

class Tweet {
  String id;
  String text;
  int numLikes;
  bool isLikedByUser;
  DateTime creationDate;

  Tweet(
      {this.id,
      this.text,
      this.numLikes,
      this.isLikedByUser,
      this.creationDate});

  Tweet.fromDocumentSnapshot(DocumentSnapshot document)
      : id = document.reference.id,
        text = document['text'],
        numLikes = document['numLikes'],
        isLikedByUser = document['isLikedByUser'],
        creationDate = document['creationDate'].toDate();
}
