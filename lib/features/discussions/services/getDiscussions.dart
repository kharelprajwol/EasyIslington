import 'dart:convert';
import 'package:easy_islington/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';

void getDiscussions(BuildContext context) async {
  print('hello');
  final studentProvider = Provider.of<StudentProvider>(context, listen: false);
  final student = studentProvider.student;
  print(student.specialization);
  final response = await http.post(
    Uri.parse('http://192.168.0.102:3000/api/discussions'),
    body: jsonEncode({"specialization": student.specialization}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  // ignore: use_build_context_synchronously
  httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () => showSnackBar(context, "Your Discussions"));
}
