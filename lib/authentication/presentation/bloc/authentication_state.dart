part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final String message;
  AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}
