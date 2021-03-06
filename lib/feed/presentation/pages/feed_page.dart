import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetly/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:tweetly/feed/models/tweet.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';
import 'package:tweetly/feed/presentation/pages/create_tweet_page.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(Authenticate());
    BlocProvider.of<FeedBloc>(context).add(GetTweets());
  }

  Widget _createChip(Filter filter) {
    String label = "Date";
    switch (filter) {
      case Filter.date:
        label = "Date";
        break;
      case Filter.likes:
        label = "Likes";
        break;
      case Filter.recommended:
        label = "Recommended";
        break;
      default:
        label = "Date";
    }

    return RaisedButton(
      onPressed: () =>
          BlocProvider.of<FeedBloc>(context).add(SelectFilter(filter)),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tweetly",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                _createChip(Filter.date),
                _createChip(Filter.likes),
                _createChip(Filter.recommended),
              ],
            ),
            _buildFeed()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn",
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateTweetPage(),
                fullscreenDialog: true),
          );
          BlocProvider.of<FeedBloc>(context).add(GetTweets());
        },
        child: Icon(Icons.create),
      ),
    );
  }

  Widget _buildFeed() {
    return SafeArea(
      child: BlocConsumer<FeedBloc, FeedState>(
        listenWhen: (previous, current) => current is FeedError,
        listener: (context, state) => null,
        buildWhen: (previous, current) =>
            current is FeedLoaded || current is FeedLoading,
        builder: (context, state) {
          if (state is FeedLoaded) {
            return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Tweet _tweet = state.tweets[index];
                  return ListTile(
                      title: Text(
                        _tweet.text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(child: Text(_tweet.user)),
                          Flexible(child: Text(_tweet.creationDate.toString()))
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${_tweet.likes.length}"),
                          IconButton(
                              icon: Icon(
                                Icons.thumb_up,
                                color: isLikedByUser(_tweet)
                                    ? Colors.blue
                                    : Color(0XFFE0E0E0),
                              ),
                              onPressed: () {
                                BlocProvider.of<FeedBloc>(context).add(
                                    !isLikedByUser(_tweet)
                                        ? LikeTweet(
                                            _tweet,
                                            BlocProvider.of<AuthenticationBloc>(
                                                    context)
                                                .currentUser)
                                        : UnLikeTweet(
                                            _tweet,
                                            BlocProvider.of<AuthenticationBloc>(
                                                    context)
                                                .currentUser));
                              }),
                        ],
                      ));
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.tweets.length);
          } else if (state is FeedLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  bool isLikedByUser(Tweet tweet) {
    bool result = false;
    tweet.likes.forEach((element) {
      if (element.contains(
          BlocProvider.of<AuthenticationBloc>(context).currentUser?.id ??
              "non-existent")) result = true;
    });
    return result;
  }
}
