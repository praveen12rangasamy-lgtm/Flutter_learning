import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/event.dart';
import '../services/local_storage_service.dart';


// =====================================================
// EVENTS
// =====================================================

abstract class RegistrationEvent {}

class RegisterUser extends RegistrationEvent {
  final Event event;
  final String name;
  final String email;
  final String phone;

  RegisterUser({
    required this.event,
    required this.name,
    required this.email,
    required this.phone,
  });
}

class ResetRegistration
    extends RegistrationEvent {}


// =====================================================
// STATES
// =====================================================

abstract class RegistrationState {}

class RegistrationInitial
    extends RegistrationState {}

class RegistrationLoading
    extends RegistrationState {}

class RegistrationSuccess
    extends RegistrationState {
  final String message;

  RegistrationSuccess({
    required this.message,
  });
}

class RegistrationFailure
    extends RegistrationState {
  final String message;

  RegistrationFailure({
    required this.message,
  });
}


// =====================================================
// BLOC
// =====================================================

class RegistrationBloc
    extends Bloc<
        RegistrationEvent,
        RegistrationState> {

  final LocalStorageService storageService;

  RegistrationBloc({
    required this.storageService,
  }) : super(
          RegistrationInitial(),
        ) {

    on<RegisterUser>(
      (event, emit) async {

        emit(
          RegistrationLoading(),
        );

        try {

          await storageService
              .saveRegistration(
            eventId: event.event.id,
            eventTitle: event.event.title,
            name: event.name,
            email: event.email,
            phone: event.phone,
          );

          emit(
            RegistrationSuccess(
              message:
                  'Successfully registered for '
                  '${event.event.title}',
            ),
          );

        } catch (error) {

          emit(
            RegistrationFailure(
              message:
                  'Registration failed. '
                  'Please try again.',
            ),
          );
        }
      },
    );


    on<ResetRegistration>(
      (event, emit) {
        emit(
          RegistrationInitial(),
        );
      },
    );
  }
}