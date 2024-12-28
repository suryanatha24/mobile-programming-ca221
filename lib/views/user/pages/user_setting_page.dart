import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/resources/dimentions.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class UserSettingPage extends StatelessWidget {
  static const String routeName = '/user/setting';
  const UserSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: largeSize,
        ),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLoggedOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
