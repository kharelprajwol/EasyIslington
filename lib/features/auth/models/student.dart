import 'dart:convert';

class Student {
  String id;
  String firstName;
  String lastName;
  String email;
  String username;
  String password;
  String specialization;
  String year;
  String semester;
  String group;
  String token;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
    required this.specialization,
    required this.year,
    required this.semester,
    required this.group,
    required this.token,
  });

  Student.update({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.username = '',
    this.password = '',
    this.specialization = '',
    this.year = '',
    this.semester = '',
    this.group = '',
    this.token = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password,
      'specialization': specialization,
      'year': year,
      'semester': semester,
      'group': group,
      'token': token,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      specialization: map['specialization'],
      year: map['year'],
      semester: map['semester'],
      group: map['group'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
}
