import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tweetly/authentication/data/authentication_repository.dart';
import 'package:tweetly/authentication/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository repository;
  User currentUser;
  AuthenticationBloc(this.repository) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    yield AuthenticationLoading();
    try {
      if (event is Authenticate) {
        User _user = await repository.getUser();
        currentUser = _user;
        yield AuthenticationSuccess(_user);
      }
    } catch (e) {
      yield AuthenticationError(e.toString());
    }
  }
}
