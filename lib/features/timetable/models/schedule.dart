import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Schedule {
  final String id;
  final String day;
  final String courseName;
  final String instructorName;
  final String block;
  final String classroom;
  final String classType;
  final String startTime;
  final String endTime;
  Schedule({
    required this.id,
    required this.day,
    required this.courseName,
    required this.instructorName,
    required this.block,
    required this.classroom,
    required this.classType,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'day': day,
      'courseName': courseName,
      'instructorName': instructorName,
      'block': block,
      'classroom': classroom,
      'classType': classType,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['_id'] as String,
      day: map['day'] as String,
      courseName: map['module_title'] as String,
      instructorName: map['instructor_name'] as String,
      block: map['block'] as String,
      classroom: map['room'] as String,
      classType: map['class_type'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);
}
