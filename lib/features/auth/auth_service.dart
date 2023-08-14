import 'dart:convert';

import 'package:easy_islington/constants/error_handling.dart';
import 'package:easy_islington/features/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants/utils.dart';
import '../../providers/student_provider.dart';
import '../class_schedule/class_schedule_service.dart';
import './models/student.dart';

class AuthService {
  final String apiUrl = 'http://192.168.0.107:3000/api';

  Future<void> signinStudent({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          // <-- Rename this
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      http.Response res = await http.post(
        Uri.parse('$apiUrl/signin'),
        body: json.encode({"username": username, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      // Manually handling response
      if (res.statusCode == 200) {
        //Navigator.of(context).pop(); // Close the CircularProgressIndicator

        Provider.of<StudentProvider>(context, listen: false)
            .setStudent(res.body);
        getSchedule(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Navigator.of(context).pop(); // Close the CircularProgressIndicator
        showSnackBar(context, 'Failed to sign in. Please try again.');
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the CircularProgressIndicator
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signupStudent({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
    required String specialization,
    required String year,
    required String semester,
    required String group,
  }) async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        specialization.isEmpty ||
        year.isEmpty ||
        semester.isEmpty ||
        group.isEmpty) {
      showSnackBar(context, 'All fields are required.');
      return;
    }

    try {
      Student student = Student(
        id: '',
        firstName: firstName,
        lastName: lastName,
        email: email,
        username: username,
        password: password,
        specialization: specialization,
        year: year,
        semester: semester,
        group: group,
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$apiUrl/api/signup'),
        body: student.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () => showSnackBar(context, 'Account created successfully!'),
      );
    } catch (e) {
      showSnackBar(context, 'Error: ${e.toString()}');
    }
  }
}
