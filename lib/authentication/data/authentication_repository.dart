import 'package:tweetly/authentication/data/datasources/authentication_datasource.dart';
import 'package:tweetly/authentication/models/user.dart';

class AuthenticationRepository {
  AuthenticationDataSource _dataSource;

  AuthenticationRepository(this._dataSource);

  Future<User> getUser(int deviceId) {
    return _dataSource.getUser(deviceId);
  }
}
