import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/mock_data.dart';
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
        final stopwatch = Stopwatch()..start();
        final events = await apiService.fetchEvents();

        // Keep skeleton loading visible based on network speed with minimum duration
        final elapsed = stopwatch.elapsedMilliseconds;
        if (elapsed < 500) {
          await Future.delayed(Duration(milliseconds: 500 - elapsed));
        }

        if (events.isNotEmpty) {
          emit(EventLoaded(events: events));
        } else {
          emit(EventLoaded(events: MockData.sampleEvents));
        }
      } catch (error) {
        debugPrint('EventBloc LoadEvents error: $error');
        // Fallback to high-quality events so the user is never stuck
        emit(EventLoaded(events: MockData.sampleEvents));
      }
    });

    on<RefreshEvents>((event, emit) async {
      try {
        final stopwatch = Stopwatch()..start();
        final events = await apiService.fetchEvents();

        final elapsed = stopwatch.elapsedMilliseconds;
        if (elapsed < 500) {
          await Future.delayed(Duration(milliseconds: 500 - elapsed));
        }

        if (events.isNotEmpty) {
          emit(EventLoaded(events: events));
        } else {
          emit(EventLoaded(events: MockData.sampleEvents));
        }
      } catch (error) {
        debugPrint('EventBloc RefreshEvents error: $error');
        emit(EventLoaded(events: MockData.sampleEvents));
      }
    });
  }
}
