part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class GetTweets extends FeedEvent {}

class CreateTweet extends FeedEvent {
  final String text;

  CreateTweet(this.text);
}

class UpdateTweet extends FeedEvent {
  final Tweet tweet;

  UpdateTweet(this.tweet);
}

class SelectFilter extends FeedEvent {
  final Filter filter;
  SelectFilter(this.filter);
}

enum Filter { date, likes, recommended }
