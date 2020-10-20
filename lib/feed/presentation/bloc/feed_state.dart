part of 'feed_bloc.dart';

@immutable
abstract class FeedState extends Equatable {}

class FeedInitial extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedError extends FeedState {
  final String message;

  FeedError(this.message);

  @override
  List<Object> get props => [message];
}

class FeedLoaded extends FeedState {
  final List<Tweet> tweets;

  FeedLoaded(this.tweets);

  @override
  List<Object> get props => [tweets];
}
