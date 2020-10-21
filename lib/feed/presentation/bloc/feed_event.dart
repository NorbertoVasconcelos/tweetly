part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class GetTweets extends FeedEvent {}

class CreateTweet extends FeedEvent {
  final String text;
  final User user;

  CreateTweet(this.text, this.user);
}

class LikeTweet extends FeedEvent {
  final Tweet tweet;
  final User user;

  LikeTweet(this.tweet, this.user);
}

class UnLikeTweet extends FeedEvent {
  final Tweet tweet;
  final User user;

  UnLikeTweet(this.tweet, this.user);
}

class SelectFilter extends FeedEvent {
  final Filter filter;
  SelectFilter(this.filter);
}

enum Filter { date, likes, recommended }
