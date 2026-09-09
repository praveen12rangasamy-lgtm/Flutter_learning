import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/screens/not_found_screen.dart';
import '../core/services/local_storage_service.dart';
import '../features/authentication/screens/sign_in_screen.dart';
import '../features/authentication/screens/sign_up_screen.dart';
import '../features/events/blocs/registration_bloc.dart';
import '../features/events/models/event.dart';
import '../features/events/screens/event_details_screen.dart';
import '../features/events/screens/event_list_screen.dart';
import '../features/events/screens/registration_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
      case RouteNames.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      case RouteNames.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: settings,
        );

      case RouteNames.eventList:
        return MaterialPageRoute(
          builder: (_) => const EventListScreen(),
          settings: settings,
        );

      case RouteNames.eventDetails:
        if (settings.arguments is Event) {
          final event = settings.arguments as Event;
          return MaterialPageRoute(
            builder: (_) => EventDetailsScreen(event: event),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(routeName: 'Invalid Event Data'),
          settings: settings,
        );

      case RouteNames.registration:
        if (settings.arguments is Event) {
          final event = settings.arguments as Event;
          return MaterialPageRoute(
            builder: (_) => BlocProvider<RegistrationBloc>(
              create: (context) => RegistrationBloc(
                storageService: LocalStorageService(),
              ),
              child: RegistrationScreen(event: event),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(routeName: 'Invalid Event Data'),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(routeName: settings.name),
          settings: settings,
        );
    }
  }
}
