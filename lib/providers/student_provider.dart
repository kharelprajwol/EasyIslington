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
}
