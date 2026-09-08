import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/event.dart';
import '../services/event_api_service.dart';


// =====================================================
// EVENTS
// =====================================================

abstract class EventEvent {}

class LoadEvents extends EventEvent {}

class RefreshEvents extends EventEvent {}


// =====================================================
// STATES
// =====================================================

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  EventLoaded({
    required this.events,
  });
}

class EventError extends EventState {
  final String message;

  EventError({
    required this.message,
  });
}


// =====================================================
// BLOC
// =====================================================

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventApiService apiService;

  EventBloc({
    required this.apiService,
  }) : super(EventInitial()) {

    on<LoadEvents>((event, emit) async {
      emit(EventLoading());

      try {
        final events =
            await apiService.fetchEvents();

        emit(
          EventLoaded(
            events: events,
          ),
        );
      } catch (error) {
        emit(
          EventError(
            message:
                'Failed to load events',
          ),
        );
      }
    });


    on<RefreshEvents>((event, emit) async {
      try {
        final events =
            await apiService.fetchEvents();

        emit(
          EventLoaded(
            events: events,
          ),
        );
      } catch (error) {
        emit(
          EventError(
            message:
                'Failed to refresh events',
          ),
        );
      }
    });
  }
}