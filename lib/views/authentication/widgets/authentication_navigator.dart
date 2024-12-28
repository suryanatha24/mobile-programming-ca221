import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/login_page.dart';
import '../../common/pages/home_page.dart';
import '../../common/pages/splash_page.dart';
import '../bloc/authentication_bloc.dart';
import '../pages/register_page.dart';

class AuthenticationNavigator extends StatefulWidget {
  static const routeName = '/';
  const AuthenticationNavigator({super.key});

  @override
  State<AuthenticationNavigator> createState() =>
      _AuthenticationNavigatorState();
}

class _AuthenticationNavigatorState extends State<AuthenticationNavigator> {
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(const AuthenticationLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => current is AuthenticationActionState,
      buildWhen: (previous, current) =>
          (previous is AuthenticationSigninInState &&
              current is AuthenticationSignInErrorActionState) ||
          current is! AuthenticationActionState,
      listener: (context, state) {
        if (state is AuthenticationNavigateBackActionState) {
          Navigator.pop(context);
        } else if (state is AuthenticationNavigateToRegisterActionState) {
          Navigator.pushNamed(context, RegisterPage.routeName);
        } else if (state is AuthenticationNavigateToForgotPasswordActionState) {
          // Navigator.pushNamed(context, ForgotPasswordPage.routeName);
        } else if (state is AuthenticationSigninInSuccessActionState) {
          context
              .read<AuthenticationBloc>()
              .add(const AuthenticationLoadEvent());
        } else if (state is AuthenticationSignInErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is AuthenticationSigningUpSuccessActionState) {
          Navigator.pop(context);
        } else if (state is AuthenticationSignUpErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is AuthenticationForgotPasswordSuccessActionState) {
          Navigator.pop(context);
          // Navigator.pushNamed(context, ForgotPasswordSuccessPage.routeName);
        } else if (state is AuthenticationForgotPasswordErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is AuthenticationLogOutSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User logged out successfully'),
            ),
          );
          context
              .read<AuthenticationBloc>()
              .add(const AuthenticationLoadEvent());
        } else if (state is AuthenticationLogOutErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        if (state.runtimeType == AuthenticationAuthenticatedState) {
          final activeState = state as AuthenticationAuthenticatedState;
          if (activeState.userData != null) {
            return const HomePage();
          }
          return const LoginPage();
        } else if (state.runtimeType == AuthenticationLoadingState) {
          return const SplashPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
