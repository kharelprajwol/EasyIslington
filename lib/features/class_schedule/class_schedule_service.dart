import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:easy_islington/providers/student_provider.dart';
import '../../constants/error_handling.dart';
import '../../constants/utils.dart';
import '../../providers/class_schedule_provider.dart';
import 'models/class_schedule.dart';

Future<List<Schedule>> getSchedule(BuildContext context) async {
  try {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final student = studentProvider.student;

    print(student.specialization);

    http.Response res = await http.post(
      Uri.parse('http://192.168.0.107:3000/api/schedules'),
      body: jsonEncode({
        "specialization": student.specialization,
        "year": student.year,
        "semester": student.semester,
        "section": student.group,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<Schedule> schedules = [];

    var classScheduleProvider =
        Provider.of<ClassScheduleProvider>(context, listen: false);

// ignore: use_build_context_synchronously
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // If schedules are not empty, clear them
          if (classScheduleProvider.schedules.isNotEmpty) {
            classScheduleProvider.clearSchedules();
          }

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

              classScheduleProvider.addSchedule(schedule);
              schedules.add(schedule);
            });
          });
        });

    return schedules;
  } catch (e) {
    print(e.toString());
    showSnackBar(context, e.toString());
    return [];
  }
}
