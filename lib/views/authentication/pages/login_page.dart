import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/dimentions.dart';
import '../../../models/user.dart';
import '../../common/widgets/small_circular_progress_indicator.dart';
import '../bloc/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/auth/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  var _passwordVisible = false;

  Future<void> _submit({bool isDemo = false}) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
      final userLogin = UserLoginDto(
        username: _authData['username']!.toLowerCase().trim(),
        password: _authData['password']!.trim(),
      );
      context.read<AuthenticationBloc>().add(
            AuthenticationLoggedInEvent(userData: userLogin),
          );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Failed to authenticate user, please check your connectivity or credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthenticationBloc>().state
        is AuthenticationSigninInState;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        height: 200,
                        width: 100,
                      ),
                      const SizedBox(height: extraLargeSize),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: largeSize),
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text('Username'),
                              TextFormField(
                                controller: _usernameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'Your username, like @moment',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  prefixIcon:
                                      Icon(Icons.alternate_email_rounded),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    _authData['username'] = newValue
                                        .toString()
                                        .replaceAll('@', '')
                                        .trim();
                                  }
                                },
                              ),
                              const Text('Password'),
                              TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.send,
                                decoration: InputDecoration(
                                  hintText: 'Your secret password',
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  prefixIcon: const Icon(Icons.lock_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        _passwordVisible = !_passwordVisible),
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    _authData['password'] =
                                        newValue.toString().trim();
                                  }
                                },
                                onFieldSubmitted: (_) => _submit(),
                                obscureText: !_passwordVisible,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: smallSize),
                      InkWell(
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onTap: () {
                          context.read<AuthenticationBloc>().add(
                              AuthenticationNavigateToForgotPasswordEvent());
                        },
                      ),
                      const SizedBox(height: mediumSize),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _submit,
                        child: isLoading
                            ? const SmallCircularProgressIndicator()
                            : const Text('Login'),
                      ),
                      const SizedBox(height: largeSize),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<AuthenticationBloc>().add(
                                        AuthenticationNavigateToRegisterEvent());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
