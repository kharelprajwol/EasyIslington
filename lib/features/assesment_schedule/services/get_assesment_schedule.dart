import 'dart:convert';
import 'package:easy_islington/features/assesment_schedule/models/assesment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/error_handling.dart';
import '../../../providers/assessment_schedule_provider.dart';
import '../../../providers/student_provider.dart';

Future<List<Assessment>> getAssessmentData(BuildContext context) async {
  try {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final student = studentProvider.student;
    print(student.specialization);
    final response = await http.post(
      Uri.parse('http://100.64.213.37:3000/api/assesmentschedule'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'specialization': student.specialization,
        'year': student.year,
      }),
    );

    List<Assessment> assessments = [];

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        List<dynamic> data = jsonDecode(response.body);
        data.forEach((moduleData) {
          List<dynamic> assessmentData = moduleData['assessments'];
          assessmentData.forEach((data1) {
            Assessment assessment = Assessment(
                id: data1['_id'],
                module_title: moduleData['module_title'],
                name: data1['name'],
                percentageWeight: data1['percentage_weight'],
                courseworkSubmissionDeadline:
                    data1['coursework_submission_deadline'],
                examDate: data1['exam_date']);
            Provider.of<AssessmentScheduleProvider>(context, listen: false)
                .addAssessment(assessment);
            assessments.add(assessment);
          });
        });
      },
    );

    return assessments;
  } catch (e) {
    // Handle any exceptions thrown during the request
    print(e);
    return [];
  }
}
