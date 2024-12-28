part of 'moment_bloc.dart';

sealed class MomentState extends Equatable {
  const MomentState();

  @override
  List<Object> get props => [];
}

final class MomentInitial extends MomentState {}

// Basis State untuk Action State
abstract class MomentActionState extends MomentState {
  const MomentActionState();
}

// Basis State untuk Loading State
abstract class MomentLoadingState extends MomentState {}

final class MomentGetLoadingState extends MomentLoadingState {}

final class MomentGetSuccessState extends MomentState {
  final List<Moment> moments;

  const MomentGetSuccessState(this.moments);
}

class MomentGetErrorActionState extends MomentActionState {
  final String message;

  const MomentGetErrorActionState(this.message);
}

final class MomentGetByIdLoadingState extends MomentLoadingState {}

final class MomentGetByIdSuccessState extends MomentState {
  final Moment moment;

  const MomentGetByIdSuccessState(this.moment);
}

class MomentGetByIdErrorActionState extends MomentActionState {
  final String message;

  const MomentGetByIdErrorActionState(this.message);
}

final class MomentAddingState extends MomentLoadingState {}

final class MomentAddedSuccessActionState extends MomentActionState {
  final Moment moment;

  const MomentAddedSuccessActionState(this.moment);
}

final class MomentAddedErrorActionState extends MomentActionState {
  final String message;

  const MomentAddedErrorActionState(this.message);
}

final class MomentUpdatingState extends MomentLoadingState {}

final class MomentUpdatedSuccessActionState extends MomentActionState {
  final Moment moment;

  const MomentUpdatedSuccessActionState(this.moment);
}

final class MomentUpdatedErrorActionState extends MomentActionState {
  final String message;

  const MomentUpdatedErrorActionState(this.message);
}

final class MomentDeletingState extends MomentLoadingState {}

final class MomentDeletedSuccessActionState extends MomentActionState {}

final class MomentDeletedErrorActionState extends MomentActionState {
  final String message;

  const MomentDeletedErrorActionState(this.message);
}

final class MomentNavigateToAddActionState extends MomentActionState {}

final class MomentNavigateToUpdateActionState extends MomentActionState {
  final String momentId;

  const MomentNavigateToUpdateActionState(this.momentId);
}

final class MomentNavigateToDeleteActionState extends MomentActionState {
  final String momentId;

  const MomentNavigateToDeleteActionState(this.momentId);
}

final class MomentNavigateBackActionState extends MomentActionState {}
