import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Assessment {
  final String id;
  final String module_title;
  final String name;
  final String percentageWeight;
  final String courseworkSubmissionDeadline;
  final String examDate;
  Assessment({
    required this.id,
    required this.module_title,
    required this.name,
    required this.percentageWeight,
    required this.courseworkSubmissionDeadline,
    required this.examDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'module_title': module_title,
      'name': name,
      'percentageWeight': percentageWeight,
      'courseworkSubmissionDeadline': courseworkSubmissionDeadline,
      'examDate': examDate,
    };
  }

  factory Assessment.fromMap(Map<String, dynamic> map) {
    return Assessment(
      id: map['id'] as String,
      module_title: map['module_title'] as String,
      name: map['name'] as String,
      percentageWeight: map['percentageWeight'] as String,
      courseworkSubmissionDeadline:
          map['courseworkSubmissionDeadline'] as String,
      examDate: map['examDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assessment.fromJson(String source) =>
      Assessment.fromMap(json.decode(source) as Map<String, dynamic>);
}
