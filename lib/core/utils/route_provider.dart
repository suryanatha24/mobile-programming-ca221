import 'package:flutter/material.dart';
import 'package:myapp/views/user/pages/user_page.dart';

import '../../views/authentication/pages/login_page.dart';
import '../../views/authentication/pages/register_page.dart';
import '../../views/authentication/widgets/authentication_navigator.dart';
import '../../views/comment/pages/comment_page.dart';
import '../../views/comment/pages/commment_entry_page.dart';
import '../../views/common/pages/home_page.dart';
import '../../views/moment/pages/moment_entry_page.dart';
import '../../views/user/pages/user_setting_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthenticationNavigator.routeName:
        return MaterialPageRoute(
            builder: (_) => const AuthenticationNavigator());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case MomentEntryPage.routeName:
        final momentId = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => MomentEntryPage(momentId: momentId));
      case CommentPage.routeName:
        final momentId = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => CommentPage(momentId: momentId!));
      case CommentEntryPage.routeName:
        final commentId = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => CommentEntryPage(commentId: commentId));
      case UserPage.routeName:
        return MaterialPageRoute(builder: (_) => const UserPage());
      case UserSettingPage.routeName:
        return MaterialPageRoute(builder: (_) => const UserSettingPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
