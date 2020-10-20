import 'package:tweetly/authentication/models/user.dart';

abstract class AuthenticationDataSource {
  Future<User> getUser(int deviceId);
}

class AuthenticationMockDataSource implements AuthenticationDataSource {
  @override
  Future<User> getUser(int deviceId) {
    return Future.delayed(Duration(seconds: 1), () => User(1, "Norberto"));
  }
}
