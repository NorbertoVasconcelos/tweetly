import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tweetly/authentication/models/user.dart';
import 'package:tweetly/feed/data/feed_repository.dart';
import 'package:tweetly/feed/models/tweet.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _repository;
  Filter _selectedFilter = Filter.date;

  FeedBloc(this._repository) : super(FeedInitial());

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    try {
      if (event is GetTweets) {
        yield FeedLoading();
        List<Tweet> tweets = await _repository.getTweets(_selectedFilter);
        yield FeedLoaded(tweets);
      } else if (event is LikeTweet) {
        await _repository.likeTweet(tweet: event.tweet, user: event.user);
        List<Tweet> tweets = await _repository.getTweets(_selectedFilter);
        yield FeedLoaded(tweets);
      } else if (event is UnLikeTweet) {
        await _repository.unlikeTweet(tweet: event.tweet, user: event.user);
        List<Tweet> tweets = await _repository.getTweets(_selectedFilter);
        yield FeedLoaded(tweets);
      } else if (event is CreateTweet) {
        await _repository.createTweet(event.text, event.user);
      } else if (event is SelectFilter) {
        _selectedFilter = event.filter;
        List<Tweet> tweets = await _repository.getTweets(_selectedFilter);
        yield FeedLoaded(tweets);
      }
    } catch (e) {
      yield FeedError(e.toString());
    }
  }
}
