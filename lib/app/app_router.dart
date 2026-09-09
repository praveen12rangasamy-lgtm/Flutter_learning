import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../routes/route_names.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) =>
      AppRoutes.generateRoute(settings);

  static const String initialRoute = RouteNames.initial;
}
