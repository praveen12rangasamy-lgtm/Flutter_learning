import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/events/blocs/event_bloc.dart';
import '../features/events/services/event_api_service.dart';

class AppProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<EventBloc>(
          create: (context) => EventBloc(
            apiService: EventApiService(),
          )..add(LoadEvents()),
        ),
      ];
}
