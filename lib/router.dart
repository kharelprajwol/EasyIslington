import 'package:flutter/material.dart';

import 'features/auth/screens/home_screen.dart';
import 'features/auth/screens/signin_screen.dart';
import 'features/timetable/screens/schedule_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case ScheduleScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ScheduleScreen(),
    //   );
    case DashboardScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DashboardScreen(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(child: Text('Screen does not exist')),
              ));
  }
}
