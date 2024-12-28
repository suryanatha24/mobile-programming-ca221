import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repositories/contracts/abs_api_user_data_repository.dart';

import '../../repositories/contracts/abs_api_moment_repository.dart';
import '../../repositories/contracts/abs_auth_repository.dart';
import '../../views/authentication/bloc/authentication_bloc.dart';
import '../../views/moment/bloc/moment_bloc.dart';
import '../../views/user/bloc/user_data_bloc.dart';

final blocProviders = [
  BlocProvider<AuthenticationBloc>(
    create: (context) => AuthenticationBloc(
      context.read<AbsAuthRepository>(),
    ),
  ),
  BlocProvider<MomentBloc>(
    create: (context) => MomentBloc(
      context.read<AbsApiMomentRepository>(),
    ),
  ),
  BlocProvider<UserDataBloc>(
    create: (context) => UserDataBloc(
      context.read<AbsApiUserDataRepository>(),
    ),
  ),
];
