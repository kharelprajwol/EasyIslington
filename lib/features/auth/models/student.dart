import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;
  final String specialization;
  final String year;
  final String semester;
  final String group;
  final String token;
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      id: map['_id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      specialization: map['specialization'] as String,
      year: map['year'] as String,
      semester: map['semester'] as String,
      group: map['group'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
}
