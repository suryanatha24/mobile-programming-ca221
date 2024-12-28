part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

abstract class AuthenticationActionState extends AuthenticationState {}

final class AuthenticationInitialState extends AuthenticationState {}

final class AuthenticationAuthenticatedState extends AuthenticationState {
  final User? userData;
  const AuthenticationAuthenticatedState(
    this.userData,
  );
}

final class AuthenticationUnauthenticatedState extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {}

final class AuthenticationSigninInState extends AuthenticationState {}

final class AuthenticationSigninUpState extends AuthenticationState {}

final class AuthenticationForgotPasswordState extends AuthenticationState {}

final class AuthenticationNavigateBackActionState
    extends AuthenticationActionState {}

final class AuthenticationNavigateToRegisterActionState
    extends AuthenticationActionState {}

final class AuthenticationNavigateToForgotPasswordActionState
    extends AuthenticationActionState {}

final class AuthenticationSigninInSuccessActionState
    extends AuthenticationActionState {
  final User? userProfile;
  AuthenticationSigninInSuccessActionState(
    this.userProfile,
  );
}

final class AuthenticationLogOutSuccessActionState
    extends AuthenticationActionState {
  AuthenticationLogOutSuccessActionState();
}

final class AuthenticationSigningUpSuccessActionState
    extends AuthenticationActionState {}

final class AuthenticationForgotPasswordSuccessActionState
    extends AuthenticationActionState {}

final class AuthenticationSignInErrorActionState
    extends AuthenticationActionState {
  final String errorMessage;
  AuthenticationSignInErrorActionState(this.errorMessage);
}

final class AuthenticationSignUpErrorActionState
    extends AuthenticationActionState {
  final String errorMessage;
  AuthenticationSignUpErrorActionState(this.errorMessage);
}

final class AuthenticationLogOutErrorActionState
    extends AuthenticationActionState {
  final String errorMessage;
  AuthenticationLogOutErrorActionState(this.errorMessage);
}

final class AuthenticationForgotPasswordErrorActionState
    extends AuthenticationActionState {
  final String errorMessage;
  AuthenticationForgotPasswordErrorActionState(this.errorMessage);
}
