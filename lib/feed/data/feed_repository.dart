import 'package:tweetly/authentication/models/user.dart';
import 'package:tweetly/feed/data/datasources/feed_datasource.dart';
import 'package:tweetly/feed/models/tweet.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';

class FeedRepository {
  FeedDataSource _dataSource;

  FeedRepository(this._dataSource);

  Future<List<Tweet>> getTweets(Filter filter) {
    return _dataSource.getTweets(filter);
  }

  Future<void> likeTweet({Tweet tweet, User user}) {
    return _dataSource.likeTweet(tweet: tweet, user: user);
  }

  Future<void> unlikeTweet({Tweet tweet, User user}) {
    return _dataSource.unlikeTweet(tweet: tweet, user: user);
  }

  Future<void> createTweet(String text, User user) {
    return _dataSource.createTweet(text, user);
  }
}
