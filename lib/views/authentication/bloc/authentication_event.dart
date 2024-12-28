part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationLoadEvent extends AuthenticationEvent {
  final bool force;
  const AuthenticationLoadEvent([this.force = false]);
}

final class AuthenticationLoggedInEvent extends AuthenticationEvent {
  final UserLoginDto userData;

  const AuthenticationLoggedInEvent({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}

final class AuthenticationRegisterEvent extends AuthenticationEvent {
  final UserRegisterDto userData;

  const AuthenticationRegisterEvent({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}

final class AuthenticationForgotPasswordEvent extends AuthenticationEvent {
  final String username;

  const AuthenticationForgotPasswordEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

final class AuthenticationLoggedOutEvent extends AuthenticationEvent {}

final class AuthenticationNavigateBackEvent extends AuthenticationEvent {}

final class AuthenticationNavigateToRegisterEvent extends AuthenticationEvent {}

final class AuthenticationNavigateToForgotPasswordEvent
    extends AuthenticationEvent {}
