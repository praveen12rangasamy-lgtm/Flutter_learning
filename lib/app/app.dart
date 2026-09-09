import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../providers/app_providers.dart';
import 'app_constants.dart';
import 'app_router.dart';
import 'app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        initialRoute: AppRouter.initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}

// Alias for backwards compatibility
typedef MyApp = App;
