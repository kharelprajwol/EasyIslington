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
import 'screens/signin_screen.dart';

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

        Navigator.of(context).push(
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
        Uri.parse('$apiUrl/signup'),
        body: student.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Account created successfully! You will now be navigated to the sign-in page.');
          Future.delayed(Duration(seconds: 4), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  SigninScreen(), // Assuming this is the name of your sign-in screen widget
            ));
          });
        },
      );
    } catch (e) {
      showSnackBar(context, 'Error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> checkEmailExists({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$apiUrl/check-email'), // Assuming 'checkEmail' is the endpoint for the checkEmailInDatabase controller
        body: json.encode({"email": email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(res.body);
        if (responseBody.containsKey('exists') &&
            responseBody['exists'] == true) {
          return {
            'status': false,
            'message': 'Email already exists',
          };
        } else {
          return {
            'status': true,
            'message': 'Email does not exist',
          };
        }
      } else {
        return {
          'status': false,
          'message': 'Failed to check email existence. Please try again.',
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}
