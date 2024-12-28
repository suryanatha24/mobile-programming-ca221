import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/models/moment.dart';
import '../../../repositories/contracts/abs_api_user_data_repository.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AbsApiUserDataRepository _apiUserDataRepository;
  List<Moment> _userMoments = [];
  UserDataBloc(this._apiUserDataRepository) : super(UserDataInitial()) {
    on<UserDataLoadEvent>(userDataLoadEvent);
  }

  List<Moment> get userMoments => _userMoments;

  FutureOr<void> userDataLoadEvent(
      UserDataLoadEvent event, Emitter<UserDataState> emit) async {
    emit(UserDataLoadingState());
    try {
      _userMoments = await _apiUserDataRepository.getAllMoments();
      emit(UserDataLoadedSuccessState(_userMoments));
    } catch (e) {
      log(e.toString(), name: 'UserDataBloc:userDataLoadEvent');
      emit(const UserDataLoadErrorActionState('Failed to load user data.'));
    }
  }
}
