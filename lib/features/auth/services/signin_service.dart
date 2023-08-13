import 'dart:convert';
import 'package:easy_islington/features/auth/screens/home_screen.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:easy_islington/constants/error_handling.dart';
import 'package:easy_islington/providers/student_provider.dart';
import 'package:easy_islington/constants/utils.dart';
// import '../../../providers/gradehub_provider.dart';
// import '../../assesment_schedule/services/get_assesment_schedule.dart';
// import '../../timetable/services/schedule_service.dart';
// import '../models/student.dart';

void signinStudent({
  required BuildContext context,
  required String username,
  required String password,
}) async {
  try {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //String apiUrl = FlutterConfig.get('API_URL');

    http.Response res = await http.post(
      //Uri.parse('$apiUrl/api/signin'),
      Uri.parse('http://192.168.0.107:3000/api/signin'),
      body: jsonEncode({"username": username, "password": password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // ignore: use_build_context_synchronously
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () async {
        // Save the student data in the provider
        Provider.of<StudentProvider>(context, listen: false)
            .setStudent(res.body);

        // Get the student ID from the provider
        //String studentId =
        //Provider.of<StudentProvider>(context, listen: false).student.id;

        // Get the schedule data and navigate to the dashboard
        // await getSchedule(context);
        // await getAssessmentData(context);

        // Fetch and set years data
        // await Provider.of<GradeHubProvider>(context, listen: false)
        //     .fetchAndSetYears("12345");

        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
            context, DashboardScreen.routeName, (route) => false);
      },
    );
  } catch (e) {
    Navigator.of(context).pop();
    showSnackBar(context, e.toString());
  }
}
