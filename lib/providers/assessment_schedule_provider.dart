import 'package:flutter/material.dart';

import '../features/assesment_schedule/models/assesment.dart';

class AssessmentScheduleProvider extends ChangeNotifier {
  Assessment _assessment = Assessment(
    id: '',
    name: '',
    percentageWeight: '',
    courseworkSubmissionDeadline: '',
    examDate: '',
    module_title: '',
  );

  AssessmentScheduleProvider() {
    _assessments = <Assessment>[];
  }

  List<Assessment> _assessments = <Assessment>[];

  Assessment get assessment => _assessment;

  List<Assessment> get assessments => _assessments;

  void setAssessment(String assessment) {
    _assessment = Assessment.fromJson(assessment);
    notifyListeners();
  }

  void setAssessmentFromModel(Assessment assessment) {
    _assessment = assessment;
    notifyListeners();
  }

  void addAssessment(Assessment assessment) {
    _assessments.add(assessment);
    notifyListeners();
  }

  void addAssessments(List<Assessment> assessments) {
    for (Assessment assessment in assessments) {
      _assessments.add(assessment);
    }
    notifyListeners();
  }
}
