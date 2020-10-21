import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetly/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';

class CreateTweetPage extends StatefulWidget {
  CreateTweetPage({Key key}) : super(key: key);

  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        title: Text(
          "Create Tweet",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => setState(() {}),
                controller: _textEditingController,
                maxLengthEnforced: true,
                maxLength: 280,
                maxLines: 6,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.blue)),
                  hintText: 'Type here...',
                  helperText:
                      'Remember the limit is 280 letters, so keep it short.',
                ),
              ),
              SizedBox(height: 20),
              Hero(
                tag: "btn",
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: _textEditingController.text.isNotEmpty
                      ? () {
                          BlocProvider.of<FeedBloc>(context).add(CreateTweet(
                              _textEditingController.text,
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .currentUser));
                          Navigator.pop(context);
                        }
                      : null,
                  child: Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
