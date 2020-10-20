part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  final int deviceId;

  Authenticate({this.deviceId});
}
