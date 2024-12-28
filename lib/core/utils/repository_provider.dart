import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helpers/shared_preference_manager.dart';
import 'package:myapp/repositories/contracts/abs_api_moment_repository.dart';

import '../../repositories/api/api_auth_repository.dart';
import '../../repositories/api/api_moment_repository.dart';
import '../../repositories/api/api_user_data_repository.dart';
import '../../repositories/contracts/abs_api_user_data_repository.dart';
import '../../repositories/contracts/abs_auth_repository.dart';
import '../../repositories/contracts/abs_moment_repository.dart';
import '../../repositories/databases/db_moment_repository.dart';

final spm = SharedPreferencesManager();
final activeUserId = spm.getString(SharedPreferencesManager.keyActiveUserId);

final repositoryProviders = [
  RepositoryProvider<AbsAuthRepository>(
    create: (context) => ApiAuthRepository(),
  ),
  RepositoryProvider<AbsMomentRepository>(
    create: (context) => DbMomentRepository(),
  ),
  RepositoryProvider<AbsApiMomentRepository>(
    create: (context) => ApiMomentRepository(),
  ),
  RepositoryProvider<AbsApiUserDataRepository>(
    create: (context) => ApiUserDataRepository(activeUserId),
  ),
];
