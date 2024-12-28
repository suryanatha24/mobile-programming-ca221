part of 'moment_bloc.dart';

sealed class MomentEvent extends Equatable {
  const MomentEvent();

  @override
  List<Object> get props => [];
}

class MomentGetEvent extends MomentEvent {}

class MomentGetByIdEvent extends MomentEvent {
  final String momentId;

  const MomentGetByIdEvent(this.momentId);
}

class MomentAddEvent extends MomentEvent {
  final Moment newMoment;

  const MomentAddEvent(this.newMoment);
}

class MomentUpdateEvent extends MomentEvent {
  final Moment updatedMoment;

  const MomentUpdateEvent(this.updatedMoment);
}

class MomentDeleteEvent extends MomentEvent {
  final String momentId;

  const MomentDeleteEvent(this.momentId);
}

class MomentNavigateToAddEvent extends MomentEvent {}

class MomentNavigateToUpdateEvent extends MomentEvent {
  final String momentId;

  const MomentNavigateToUpdateEvent(this.momentId);
}

class MomentNavigateToDeleteEvent extends MomentEvent {
  final String momentId;

  const MomentNavigateToDeleteEvent(this.momentId);
}

class MomentNavigateBackEvent extends MomentEvent {}
