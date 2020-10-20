import 'package:tweetly/feed/data/datasources/feed_datasource.dart';
import 'package:tweetly/feed/models/tweet.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';

class FeedRepository {
  FeedDataSource _dataSource;

  FeedRepository(this._dataSource);

  Future<List<Tweet>> getTweets(Filter filter) {
    return _dataSource.getTweets(filter);
  }

  Future<void> setTweetState({Tweet tweet}) {
    return _dataSource.setTweetState(tweet: tweet);
  }

  Future<void> createTweet(String text) {
    return _dataSource.createTweet(text);
  }
}
