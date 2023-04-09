import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../providers/class_schedule_provider.dart';
import '../../../providers/student_provider.dart';
import '../../auth/screens/home_screen.dart';
import '../models/schedule.dart';
import '../widgets/schedule_list.dart';

class ClassScheduleScreen extends StatefulWidget {
  static const String routeName = '/schedule';

  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  //Add a Map to hold the schedules for each day
  // Map<String, String> schedules = {
  //   'Sunday': 'Schedule for Sunday',
  //   'Monday': 'Schedule for Monday',
  //   'Tuesday': 'Schedule for Tuesday',
  //   'Wednesday': 'Schedule for Wednesday',
  //   'Thursday': 'Schedule for Thursday',
  //   'Friday': 'Schedule for Friday',
  // };

  // Add a variable to keep track of which button is selected
  late String selectedDay;

  // Define button styles for selected and unselected states
  final selectedButtonStyle =
      ElevatedButton.styleFrom(primary: Colors.green.shade900);
  final unselectedButtonStyle =
      ElevatedButton.styleFrom(primary: Colors.blue.shade900);

  @override
  void initState() {
    super.initState();
    selectedDay = _getTodayLabel();
  }

  String _getTodayLabel() {
    switch (DateTime.now().weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
        title: Text('Class Schedule',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontFamily: 'Kalam',
                fontSize: 30,
              ),
            )),
        backgroundColor: Colors.red.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Note: This schedule is based on following details."),
              const SizedBox(
                height: 5,
              ),
              Consumer<StudentProvider>(
                  builder: (context, studentProvider, child) {
                final student = studentProvider.student;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Specialization: ${student.specialization}'),
                    Text('Year: ${student.year}'),
                    Text('Semester: ${student.semester}'),
                    Text('Section: ${student.section}'),
                  ],
                );
              }),
              // Text('Specialization: '),
              // Text('Year: '),
              // Text('Semester: '),
              // Text('Section: '),
              const SizedBox(
                height: 5,
              ),
              Text(
                  'If you need to make changes to these details, please update your profile in the settings section. Your schedule will be automatically updated once the changes are made.'),
              const SizedBox(
                height: 10,
              ),
              _buildButton('Sunday'),
              _buildButton('Monday'),
              _buildButton('Tuesday'),
              _buildButton('Wednesday'),
              _buildButton('Thursday'),
              _buildButton('Friday'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: selectedDay == label
                    ? selectedButtonStyle
                    : unselectedButtonStyle,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(label,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontFamily: 'Kalam',
                          fontSize: 20,
                        ),
                      )),
                ),
                onPressed: () {
                  setState(() {
                    selectedDay = label;
                  });
                },
              ),
            ),
          ],
        ),
        if (selectedDay == label)
          Consumer<ClassScheduleProvider>(
            builder: (context, provider, child) {
              final schedules = provider.schedules;
              return ScheduleList(schedules: schedules, weekday: selectedDay);
            },
          ),
      ],
    );
  }
}
