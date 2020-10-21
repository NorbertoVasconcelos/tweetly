part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  final String deviceId;

  Authenticate({this.deviceId});
}
