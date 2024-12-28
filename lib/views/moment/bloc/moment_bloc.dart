import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/models/moment.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../../repositories/contracts/abs_api_moment_repository.dart';

part 'moment_event.dart';
part 'moment_state.dart';

class MomentBloc extends Bloc<MomentEvent, MomentState> {
  final AbsApiMomentRepository _momentRepository;
  List<Moment> _moments = [];
  MomentBloc(this._momentRepository) : super(MomentInitial()) {
    // _moments = List.generate(
    //   5,
    //   (index) => Moment(
    //     id: nanoid(),
    //     momentDate: _faker.date.dateTime(),
    //     creator: _faker.person.name(),
    //     location: _faker.address.city(),
    //     imageUrl: 'https://picsum.photos/800/600?random=$index',
    //     caption: _faker.lorem.sentence(),
    //     likeCount: faker.random.integer(1000),
    //     commentCount: faker.random.integer(100),
    //     bookmarkCount: faker.random.integer(10),
    //   ),
    // );

    // Deklarasikan event handler
    on<MomentGetEvent>(momentGetEvent);
    on<MomentGetByIdEvent>(momentGetByIdEvent);
    on<MomentAddEvent>(momentAddEvent);
    on<MomentUpdateEvent>(momentUpdateEvent);
    on<MomentDeleteEvent>(momentDeleteEvent);
    on<MomentNavigateToAddEvent>(momentNavigateToAddEvent);
    on<MomentNavigateToUpdateEvent>(momentNavigateToUpdateEvent);
    on<MomentNavigateToDeleteEvent>(momentNavigateToDeleteEvent);
    on<MomentNavigateBackEvent>(momentNavigateBackEvent);
  }

  List<Moment> get moments => _moments;

  Moment? getMomentById(String momentId) {
    return _moments.firstWhereOrNull((moment) => moment.id == momentId);
  }

  FutureOr<void> momentGetEvent(
      MomentGetEvent event, Emitter<MomentState> emit) async {
    emit(MomentGetLoadingState());
    try {
      _moments = await _momentRepository.getAll();
      emit(MomentGetSuccessState(_moments));
    } catch (e) {
      emit(MomentGetErrorActionState(e.toString()));
    }
  }

  FutureOr<void> momentAddEvent(
      MomentAddEvent event, Emitter<MomentState> emit) async {
    emit(MomentAddingState());
    try {
      final newAddedMoment = await _momentRepository.create(event.newMoment);
      if (newAddedMoment != null) {
        _moments.add(newAddedMoment);
        emit(MomentAddedSuccessActionState(event.newMoment));
      } else {
        emit(const MomentAddedErrorActionState('Failed to add moment.'));
      }
    } catch (e) {
      emit(MomentAddedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> momentUpdateEvent(
      MomentUpdateEvent event, Emitter<MomentState> emit) async {
    emit(MomentUpdatingState());
    try {
      final existingMoment = getMomentById(event.updatedMoment.id!);
      if (existingMoment != null) {
        final isUpdated = await _momentRepository.update(event.updatedMoment);
        if (isUpdated) {
          _moments[_moments.indexOf(existingMoment)] = event.updatedMoment;
          emit(MomentUpdatedSuccessActionState(event.updatedMoment));
        } else {
          emit(const MomentUpdatedErrorActionState('Failed to update moment.'));
        }
      } else {
        emit(const MomentUpdatedErrorActionState('Moment not found.'));
      }
    } catch (e) {
      emit(MomentUpdatedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> momentDeleteEvent(
      MomentDeleteEvent event, Emitter<MomentState> emit) async {
    emit(MomentDeletingState());
    try {
      final existingMoment = getMomentById(event.momentId);
      if (existingMoment != null) {
        final isDeleted = await _momentRepository.delete(event.momentId);
        if (isDeleted) {
          _moments.remove(existingMoment);
          emit(MomentDeletedSuccessActionState());
        } else {
          emit(const MomentDeletedErrorActionState('Failed to delete moment.'));
        }
      } else {
        emit(const MomentDeletedErrorActionState('Moment not found.'));
      }
    } catch (e) {
      emit(MomentDeletedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> momentNavigateToAddEvent(
      MomentNavigateToAddEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateToAddActionState());
  }

  FutureOr<void> momentNavigateToUpdateEvent(
      MomentNavigateToUpdateEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateToUpdateActionState(event.momentId));
  }

  FutureOr<void> momentNavigateToDeleteEvent(
      MomentNavigateToDeleteEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateToDeleteActionState(event.momentId));
  }

  FutureOr<void> momentNavigateBackEvent(
      MomentNavigateBackEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateBackActionState());
  }

  FutureOr<void> momentGetByIdEvent(
      MomentGetByIdEvent event, Emitter<MomentState> emit) async {
    emit(MomentGetByIdLoadingState());
    try {
      Moment? moment = getMomentById(event.momentId);
      moment ?? await _momentRepository.getById(event.momentId);
      if (moment != null) {
        emit(MomentGetByIdSuccessState(moment));
      } else {
        emit(const MomentGetByIdErrorActionState('Moment not found.'));
      }
    } catch (e) {
      emit(MomentGetByIdErrorActionState(e.toString()));
    }
  }
}
