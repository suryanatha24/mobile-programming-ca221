import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/dimentions.dart';
import '../../../models/user.dart';
import '../../common/widgets/small_circular_progress_indicator.dart';
import '../bloc/authentication_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/auth/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'username': '',
    'password': '',
    'firstName': '',
    'lastName': '',
  };
  var _passwordVisible = false;

  Future<void> _submit({bool isDemo = false}) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final userRegister = UserRegisterDto(
        email: _authData['email']!.toLowerCase().trim(),
        username: _authData['username']!.toLowerCase().trim(),
        password: _authData['password']!.trim(),
        firstName: _authData['firstName']!.trim(),
        lastName: _authData['lastName']!.trim(),
      );
      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationRegisterEvent(userData: userRegister),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Failed to register user, please check your connectivity or data.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (pop, _) {
        if (pop) return;
        context
            .read<AuthenticationBloc>()
            .add(AuthenticationNavigateBackEvent());
      },
      child: Scaffold(
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
                        // Image.asset(
                        //   'assets/images/register.png',
                        //   height: 200,
                        //   width: 200,
                        // ),
                        // const SizedBox(height: largeSize),
                        const Text(
                          'Register',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('First name'),
                                TextFormField(
                                  controller: _firstNameController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Your first name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    prefixIcon: Icon(Icons.badge_rounded),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    if (newValue != null) {
                                      _authData['firstName'] =
                                          newValue.toString().trim();
                                    }
                                  },
                                ),
                                const Text('Last name'),
                                TextFormField(
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Your last name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    prefixIcon: Icon(Icons.badge_rounded),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    if (newValue != null) {
                                      _authData['firstName'] =
                                          newValue.toString().trim();
                                    }
                                  },
                                ),
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
                                const Text('Email Address'),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Your email address',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    prefixIcon: Icon(Icons.mail_rounded),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 3 ||
                                        !value.contains('@')) {
                                      return 'Please enter your email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    if (newValue != null) {
                                      _authData['email'] =
                                          newValue.toString().trim();
                                    }
                                  },
                                ),
                                const Text('Password'),
                                TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
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
                                  obscureText: !_passwordVisible,
                                ),
                                const Text('Repeat Password'),
                                TextFormField(
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
                                    if (value == null ||
                                        value.isEmpty ||
                                        value != _passwordController.text) {
                                      return 'Password not match';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) => _submit(),
                                  obscureText: !_passwordVisible,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: mediumSize,
                        ),
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
                          child: context.watch<AuthenticationBloc>().state
                                  is AuthenticationSigninUpState
                              ? const SmallCircularProgressIndicator()
                              : const Text('Register'),
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
                                const TextSpan(
                                    text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.read<AuthenticationBloc>().add(
                                          AuthenticationNavigateBackEvent());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: largeSize),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
