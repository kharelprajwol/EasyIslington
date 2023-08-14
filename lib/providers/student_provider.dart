import 'package:easy_islington/features/auth/models/student.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  Student _student = Student(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    username: '',
    password: '',
    specialization: '',
    year: '',
    semester: '',
    group: '',
    token: '',
  );

  Student get student => _student;

  void setStudent(String student) {
    _student = Student.fromJson(student);
    notifyListeners();
  }

  void setStudentFromModel(Student student) {
    _student = student;
    notifyListeners();
  }

  void updateStudentFields({
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? specialization,
    String? year,
    String? semester,
    String? group,
    // add any other fields you might want to update here
  }) {
    if (firstName != null) _student.firstName = firstName;
    if (lastName != null) _student.lastName = lastName;
    if (email != null) _student.email = email;
    if (username != null) _student.username = username;
    if (specialization != null) _student.specialization = specialization;
    if (year != null) _student.year = year;
    if (semester != null) _student.semester = semester;
    if (group != null) _student.group = group;

    // Ensure you notify listeners after making changes
    notifyListeners();
  }
}
