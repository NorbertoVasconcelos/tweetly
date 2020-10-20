import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweetly/feed/models/tweet.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';

abstract class FeedDataSource {
  Future<List<Tweet>> getTweets(Filter filter);
  createTweet(String text);
  setTweetState({Tweet tweet});
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
        filterString = 'whatever';
        break;
      default:
    }
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('tweets')
        .orderBy(filterString, descending: true)
        .get();
    return snapshot.docs
        .map<Tweet>((document) => Tweet.fromDocumentSnapshot(document))
        .toList();
  }

  @override
  setTweetState({Tweet tweet}) async {
    try {
      await FirebaseFirestore.instance
          .collection('tweets')
          .doc(tweet.id)
          .update({
        "isLikedByUser": tweet.isLikedByUser,
        "numLikes":
            tweet.isLikedByUser ? tweet.numLikes + 1 : tweet.numLikes - 1
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  createTweet(String text) {
    FirebaseFirestore.instance
        .collection('tweets')
        .add({
          "text": text,
          "numLikes": 0,
          "isLikedByUser": false,
          "creationDate": DateTime.now()
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
            isLikedByUser: true,
            numLikes: 12),
        Tweet(
            id: "6",
            text: "Tweet numero 6",
            creationDate: DateTime.now(),
            isLikedByUser: false,
            numLikes: 19),
        Tweet(
            id: "7",
            text: "Tweet numero 7",
            creationDate: DateTime.now(),
            isLikedByUser: false,
            numLikes: 2),
      ];
    });
  }

  @override
  createTweet(String text) {
    // TODO: implement createTweet
    throw UnimplementedError();
  }

  @override
  setTweetState({Tweet tweet}) {
    // TODO: implement setTweetState
    throw UnimplementedError();
  }
}
