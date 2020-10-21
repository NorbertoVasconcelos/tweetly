import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweetly/authentication/models/user.dart';
import 'package:tweetly/feed/models/tweet.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';

abstract class FeedDataSource {
  Future<List<Tweet>> getTweets(Filter filter);
  createTweet(String text, User user);
  likeTweet({Tweet tweet, User user});
  unlikeTweet({Tweet tweet, User user});
}

class FeedFireStoreDataSource implements FeedDataSource {
  @override
  Future<List<Tweet>> getTweets(Filter filter) async {
    String filterString = 'creationDate';
    switch (filter) {
      case Filter.date:
        filterString = 'creationDate';
        break;
      case Filter.likes:
        filterString = 'numLikes';
        break;
      case Filter.recommended:
        filterString = 'creationDate';
        break;
      default:
    }
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tweets')
          .orderBy(filterString, descending: true)
          .get();
      List<Tweet> tweets = snapshot.docs
          .map<Tweet>((document) => Tweet.fromDocumentSnapshot(document))
          .toList();
      if (filter == Filter.recommended)
        tweets.sort((a, b) => a.text.length.compareTo(b.text.length));
      return tweets;
    } catch (e) {
      print(e.toString());
      throw Error();
    }
  }

  @override
  likeTweet({Tweet tweet, User user}) async {
    try {
      DocumentReference likesRef = FirebaseFirestore.instance
          .collection('likes')
          .doc('${user.id}:${tweet.id}');
      await likesRef.set({'state': true});

      DocumentReference tweetRef =
          FirebaseFirestore.instance.collection('tweets').doc(tweet.id);
      await tweetRef.update({
        'likes': FieldValue.arrayUnion([likesRef])
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  unlikeTweet({Tweet tweet, User user}) async {
    try {
      DocumentReference likesRef = FirebaseFirestore.instance
          .collection('likes')
          .doc('${user.id}:${tweet.id}');
      await likesRef.delete();

      DocumentReference tweetRef =
          FirebaseFirestore.instance.collection('tweets').doc(tweet.id);
      await tweetRef.update({
        'likes': FieldValue.arrayRemove([likesRef])
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  createTweet(String text, User user) {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user.id);
    FirebaseFirestore.instance
        .collection('tweets')
        .add({
          "text": text,
          "numLikes": 0,
          "creationDate": DateTime.now(),
          "likes": [],
          "user": userRef
        })
        .then((value) => null)
        .catchError(() => print("Error creating a tweet!"));
  }
}

class FeedMockDataSource implements FeedDataSource {
  @override
  Future<List<Tweet>> getTweets(Filter filter) {
    return Future.delayed(Duration(seconds: 1), () {
      return [
        Tweet(
          id: "5",
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut maximus justo, in luctus sapien. Vestibulum laoreet sem quam, porta blandit turpis hendrerit a. Donec ac lorem vitae nisi tempus suscipit sit amet congue arcu. Curabitur congue ultrices nulla at egestas. Nulla vitae dui eget tortor ullamcorper aliquet sit amet at massa.",
          creationDate: DateTime.now(),
        ),
        Tweet(
          id: "6",
          text: "Tweet numero 6",
          creationDate: DateTime.now(),
        ),
        Tweet(
          id: "7",
          text: "Tweet numero 7",
          creationDate: DateTime.now(),
        ),
      ];
    });
  }

  @override
  createTweet(String text, User user) {
    // TODO: implement createTweet
    throw UnimplementedError();
  }

  @override
  likeTweet({Tweet tweet, User user}) {
    // TODO: implement likeTweet
    throw UnimplementedError();
  }

  @override
  unlikeTweet({Tweet tweet, User user}) {
    // TODO: implement unlikeTweet
    throw UnimplementedError();
  }
}
