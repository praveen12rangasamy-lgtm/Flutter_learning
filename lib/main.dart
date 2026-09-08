import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/event_bloc.dart';
import 'screens/event_list_screen.dart';
import 'services/event_api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBloc>(
      create: (context) {
        return EventBloc(
          apiService: EventApiService(),
        )..add(
            LoadEvents(),
          );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const EventListScreen(),
      ),
    );
  }
}