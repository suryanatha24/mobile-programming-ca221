part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class UserDataLoadEvent extends UserDataEvent {}