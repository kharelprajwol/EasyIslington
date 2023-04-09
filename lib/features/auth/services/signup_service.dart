import 'package:easy_islington/constants/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/utils.dart';
import '../models/student.dart';

void signupStudent({
  required BuildContext context,
  required String firstName,
  required String lastName,
  required String email,
  required String password,
  required String specialization,
  required String year,
  required String semester,
  required String section,
}) async {
  try {
    // Print the data being sent to the server for debugging
    print(firstName);
    print(lastName);
    print(email);
    print(password);
    print(specialization);
    print(year);
    print(semester);
    print(section);

    // Create a Student object with the data entered by the user
    Student student = Student(
      id: '',
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      specialization: specialization,
      year: year,
      semester: semester,
      section: section,
      token: '',
    );

    // Make the HTTP POST request to the server and wait for the response
    http.Response res = await http.post(
      Uri.parse('http://192.168.0.102:3000/api/signup'),
      body: student.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // Handle the response according to the status code
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () => showSnackBar(context, 'Account created!'),
    );
  } catch (e) {
    // Handle any exceptions thrown during the request
    showSnackBar(context, e.toString());
  }
}
