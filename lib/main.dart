import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetly/authentication/data/authentication_repository.dart';
import 'package:tweetly/authentication/data/datasources/authentication_datasource.dart';
import 'package:tweetly/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:tweetly/feed/data/datasources/feed_datasource.dart';
import 'package:tweetly/feed/data/feed_repository.dart';
import 'package:tweetly/feed/presentation/bloc/feed_bloc.dart';
import 'package:tweetly/feed/presentation/pages/feed_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        title: 'Tweetly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FeedPage(),
      ),
    );
  }

  _getProviders() {
    return [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          AuthenticationRepository(
            AuthenticationMockDataSource(),
          ),
        ),
      ),
      BlocProvider<FeedBloc>(
        create: (context) => FeedBloc(
          FeedRepository(
            FeedFireStoreDataSource(),
          ),
        ),
      ),
    ];
  }
}
