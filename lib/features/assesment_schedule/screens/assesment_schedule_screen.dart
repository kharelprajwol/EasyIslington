import 'package:easy_islington/features/timetable/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../providers/assessment_schedule_provider.dart';
import '../../../providers/student_provider.dart';
import '../models/assesment.dart';
import '../models/assesment.dart';

class AssessmentScreen extends StatefulWidget {
  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  String _selectedModuleTitle = '';

  @override
  Widget build(BuildContext context) {
    List<Assessment> assessments =
        Provider.of<AssessmentScheduleProvider>(context).assessments;
    Set<String> moduleTitles = {};
    assessments.forEach((assessment) {
      moduleTitles.add(assessment.module_title);
    });

    if (_selectedModuleTitle.isEmpty) {
      _selectedModuleTitle = moduleTitles.elementAt(0);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assessment Schedule',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontFamily: 'Kalam',
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: Consumer<AssessmentScheduleProvider>(
        builder: (context, provider, _) {
          List<Assessment> assessments = provider.assessments;
          Set<String> moduleTitles = {};
          assessments.forEach((assessment) {
            moduleTitles.add(assessment.module_title);
          });
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Note: This schedule is based on following details:',
                ),
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
                    ],
                  );
                }),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    'If you need to make changes to these details, please update your profile in the settings section. Your schedule will be automatically updated once the changes are made.'),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: moduleTitles.length,
                    itemBuilder: (context, index) {
                      String moduleTitle = moduleTitles.elementAt(index);
                      List<Assessment> moduleAssessments = assessments
                          .where((assessment) =>
                              assessment.module_title == moduleTitle)
                          .toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedModuleTitle = moduleTitle;
                              });
                            },
                            child: Text(
                              moduleTitle,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontFamily: 'Kalam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                _selectedModuleTitle == moduleTitle
                                    ? Colors.green.shade900
                                    : Colors.blue.shade900,
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: _selectedModuleTitle == moduleTitle,
                            child: Container(
                              height: 300,
                              child: ListView.builder(
                                itemCount: moduleAssessments.length,
                                itemBuilder: (context, index) {
                                  Assessment assessment =
                                      moduleAssessments[index];
                                  return ListTile(
                                    title: Text(assessment.name),
                                    subtitle: Text(
                                        'Weightage: ${assessment.percentageWeight}%\n'
                                        'Deadline/Exam Date: ${assessment.courseworkSubmissionDeadline}\n'
                                        'Exam Date: ${assessment.examDate}'),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
