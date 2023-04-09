import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:easy_islington/providers/student_provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../providers/class_schedule_provider.dart';
import '../models/schedule.dart';
import '../screens/schedule_screen.dart';

Future<List<Schedule>> getSchedule(BuildContext context) async {
  try {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final student = studentProvider.student;

    http.Response res = await http.post(
      Uri.parse('http://192.168.1.125:3000/api/schedule'),
      body: jsonEncode({
        "specialization": student.specialization,
        "year": student.year,
        "semester": student.semester,
        "section": student.section,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<Schedule> schedules = [];
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> data = jsonDecode(res.body);
          data.forEach((scheduleData) {
            List<dynamic> classes = scheduleData['classes'];
            classes.forEach((classData) {
              Schedule schedule = Schedule(
                id: classData['_id'],
                courseName: classData['module_title'],
                instructorName: classData['instructor_name'],
                classroom: classData['room'],
                block: classData['block'],
                startTime: classData['start_time'],
                endTime: classData['end_time'],
                day: scheduleData['day_name'],
                classType: classData['class_type'],
              );
              Provider.of<ClassScheduleProvider>(context, listen: false)
                  .addSchedule(schedule);
              schedules.add(schedule);
            });
          });
        });

    return schedules;
  } catch (e) {
    showSnackBar(context, e.toString());
    return [];
  }
}
