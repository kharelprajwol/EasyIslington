import 'package:easy_islington/providers/discussions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:easy_islington/features/my_grades/screens/year_screen.dart';
import 'package:easy_islington/providers/class_schedule_provider.dart';
import 'package:easy_islington/providers/student_provider.dart';
import 'package:easy_islington/router.dart';
import 'features/dashboard/home_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/signin_screen.dart';
import 'features/discussions/Screens/discussions_screen.dart';
import 'features/grade_calculator/screens/calculator_screen.dart';

import 'features/class_schedule/widgets/schedule_tile.dart';
import 'providers/gradehub_provider.dart';

void main() async {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); // Needed for async operations before runApp
  // await FlutterConfig.loadEnvVariables(); // Load environment variables

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => StudentProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ClassScheduleProvider(),
    ),
    ChangeNotifierProvider(create: (context) => GradeHubProvider()),
    ChangeNotifierProvider(create: (context) => DiscussionsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //onGenerateRoute: (settings) => generateRoutes(settings),
      home: SigninScreen(),
      //home: DashboardScreen(),
      //home: GradeCalculatorPage(),
      //home: YearScreen(),
    );
  }
}
