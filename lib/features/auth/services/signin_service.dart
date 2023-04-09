import 'dart:convert';
import 'package:easy_islington/features/auth/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:easy_islington/constants/error_handling.dart';
import 'package:easy_islington/providers/student_provider.dart';
import 'package:easy_islington/constants/utils.dart';
import '../../assesment_schedule/services/get_assesment_schedule.dart';
import '../../timetable/services/schedule_service.dart';
import '../models/student.dart';

void signinStudent({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    // Print the data being sent to the server for debugging
    print(email);
    print(password);

    // Show a loading dialog to indicate that the request is being processed
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Make the HTTP POST request to the server and wait for the response
    http.Response res = await http.post(
      Uri.parse('http://100.64.213.37:3000/api/signin'),
      body: jsonEncode({"email": email, "password": password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // Handle the response according to the status code
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () async {
        // Save the student data in the provider
        Provider.of<StudentProvider>(context, listen: false)
            .setStudent(res.body);

        // Get the schedule data and navigate to the dashboard
        await getSchedule(context);
        await getAssessmentData(context);
        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
            context, DashboardScreen.routeName, (route) => false);
      },
    );
  } catch (e) {
    // Handle any exceptions thrown during the request
    Navigator.of(context).pop();
    showSnackBar(context, e.toString());
  }
}
