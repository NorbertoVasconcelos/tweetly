import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_id/device_id.dart';
import 'package:faker/faker.dart';
import 'package:tweetly/authentication/models/user.dart';

abstract class AuthenticationDataSource {
  Future<User> authenticate();
}

class AuthenticationFireStoreDataSource implements AuthenticationDataSource {
  @override
  Future<User> authenticate() async {
    Faker _faker = Faker();
    String deviceId = await DeviceId.getID;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(deviceId)
          .get();

      if (snapshot.exists) return User.fromSnapshot(snapshot);

      User _newUser = User(deviceId, _faker.person.name());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_newUser.id)
          .set({"name": _newUser.name});
      return _newUser;
    } catch (e) {
      throw Error();
    }
  }
}

class AuthenticationMockDataSource implements AuthenticationDataSource {
  @override
  Future<User> authenticate() {
    return Future.delayed(Duration(seconds: 1), () => User("1", "Norberto"));
  }
}
