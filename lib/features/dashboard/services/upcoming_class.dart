// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:easy_islington/providers/student_provider.dart';
// import 'package:http/http.dart' as http;

// import '../../../constants/error_handling.dart';
// import '../../../constants/utils.dart';
// import '../../timetable/models/schedule.dart';

// void getSchedule(BuildContext context) async {
//   try {
//     // create an instance of the StudentProvider class
//     final studentProvider =
//         Provider.of<StudentProvider>(context, listen: false);
//     final student = studentProvider.student;

//     http.Response res = await http.post(
//       Uri.parse('http://192.168.0.104:3000/api/schedule'),
//       body: jsonEncode({
//         "specialization": student.specialization,
//         "year": student.year,
//         "semester": student.semester,
//         "section": student.section,
//       }),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     );

//     // ignore: use_build_context_synchronously
//     httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           String currentDay = DateFormat('EEEE').format(DateTime.now());
//           List<Schedule> schedules = [];
//           List<dynamic> data = jsonDecode(res.body);
//           print(data);
//           data.forEach((scheduleData) {
//             if (scheduleData['day_name'] == currentDay) {
//               List<dynamic> classes = scheduleData['classes'];
//               classes.forEach((classData) {
//                 Schedule schedule = Schedule(
//                   id: classData['_id'],
//                   courseName: classData['module_title'],
//                   instructorName: classData['instructor_name'],
//                   classroom: classData['room'],
//                   block: classData['block'],
//                   startTime: classData['start_time'],
//                   endTime: classData['end_time'],
//                   day: scheduleData['day_name'],
//                   classType: classData['class_type'],
//                 );
//                 schedules.add(schedule);
//               });
//             }
//             print(schedules);
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         ClassScheduleScreen(schedules: schedules)));
//           });
//         });
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
// }
