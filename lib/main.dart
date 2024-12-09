import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repositories/contracts/abs_moment_repository.dart';
import 'package:myapp/repositories/databases/db_moment_repository.dart';
import 'package:myapp/views/home/pages/main_page.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:myapp/core/resources/strings.dart';
import 'package:myapp/views/moment/pages/moment_entry_page.dart';

import 'views/moment/bloc/moment_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AbsMomentRepository>(create: (context) => DbMomentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MomentBloc>(create: (context) => MomentBloc(
            RepositoryProvider.of<AbsMomentRepository>(context)
          )),
        ],
        child: MaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              useMaterial3: true,
            ),
            initialRoute: '/',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case MainPage.routeName:
                  return MaterialPageRoute(builder: (_) => const MainPage());
                case MomentEntryPage.routeName:
                  final momentId = settings.arguments as String?;
                  return MaterialPageRoute(
                      builder: (_) => MomentEntryPage(momentId: momentId));
                default:
                  return MaterialPageRoute(builder: (_) => const MainPage());
              }
            }),
      ),
    );
  }
}
