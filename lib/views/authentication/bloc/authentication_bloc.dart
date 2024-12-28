import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/models/user.dart';

import '../../../repositories/contracts/abs_auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AbsAuthRepository _authRepository;
  User? activeUser;
  AuthenticationBloc(this._authRepository)
      : super(AuthenticationInitialState()) {
    on<AuthenticationLoadEvent>(authenticationLoadEvent);
    on<AuthenticationLoggedInEvent>(authenticationLoggedInEvent);
    on<AuthenticationRegisterEvent>(authenticationRegisterEvent);
    on<AuthenticationForgotPasswordEvent>(authenticationForgotPasswordEvent);
    on<AuthenticationLoggedOutEvent>(authenticationLoggedOutEvent);
    on<AuthenticationNavigateBackEvent>(authenticationNavigateBackEvent);
    on<AuthenticationNavigateToRegisterEvent>(
        authenticationNavigateToRegisterEvent);
    on<AuthenticationNavigateToForgotPasswordEvent>(
        authenticationNavigateToForgotPasswordEvent);
  }

  FutureOr<void> authenticationNavigateBackEvent(
      AuthenticationNavigateBackEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthenticationNavigateBackActionState());
  }

  FutureOr<void> authenticationLoadEvent(
      AuthenticationLoadEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoadingState());
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        activeUser = await _authRepository.info();
        emit(AuthenticationAuthenticatedState(activeUser));
      } else {
        emit(AuthenticationUnauthenticatedState());
      }
    } catch (er) {
      log(er.toString(), name: 'auth load error');
      emit(AuthenticationUnauthenticatedState());
    }
  }

  FutureOr<void> authenticationLoggedInEvent(AuthenticationLoggedInEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSigninInState());
    try {
      final (loginResult, message) =
          await _authRepository.login(event.userData);
      if (loginResult) {
        emit(AuthenticationSigninInSuccessActionState(activeUser));
      } else {
        emit(AuthenticationSignInErrorActionState(message));
      }
    } catch (er) {
      emit(AuthenticationSignInErrorActionState(er.toString()));
    }
  }

  FutureOr<void> authenticationRegisterEvent(AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSigninUpState());
    try {
      final (registerResult, message) =
          await _authRepository.register(event.userData);
      if (registerResult) {
        emit(AuthenticationSigningUpSuccessActionState());
      } else {
        emit(AuthenticationSignUpErrorActionState(message));
      }
    } catch (er) {
      emit(AuthenticationSignInErrorActionState(er.toString()));
    }
  }

  FutureOr<void> authenticationForgotPasswordEvent(
      AuthenticationForgotPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationForgotPasswordState());
    final (forgotPasswordResult, message) =
        await _authRepository.forgotPassword(event.username);
    if (forgotPasswordResult) {
      emit(AuthenticationForgotPasswordSuccessActionState());
    } else {
      emit(AuthenticationForgotPasswordErrorActionState(message));
    }
  }

  FutureOr<void> authenticationLoggedOutEvent(
      AuthenticationLoggedOutEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoadingState());
      await _authRepository.logout();
      emit(AuthenticationLogOutSuccessActionState());
    } catch (er) {
      emit(AuthenticationLogOutErrorActionState(er.toString()));
    }
  }

  FutureOr<void> authenticationNavigateToRegisterEvent(
      AuthenticationNavigateToRegisterEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthenticationNavigateToRegisterActionState());
  }

  FutureOr<void> authenticationNavigateToForgotPasswordEvent(
      AuthenticationNavigateToForgotPasswordEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthenticationNavigateToForgotPasswordActionState());
  }
}
