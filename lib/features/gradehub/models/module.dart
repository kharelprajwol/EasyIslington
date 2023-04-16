// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'assessment.dart';

class Module {
  final String id;
  final String name;
  final int credit;
  final List<Assessment> assessments;

  Module(
      {required this.id,
      required this.name,
      required this.credit,
      required this.assessments});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'credit': credit,
      'assessments': assessments.map((x) => x.toMap()).toList(),
    };
  }

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['_id'] as String,
      name: map['name'] as String,
      credit: map['credit'] as int,
      assessments: List<Assessment>.from(
        (map['assessments'] as List<dynamic>).map<Assessment>(
          (x) => Assessment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Module.fromJson(String source) =>
      Module.fromMap(json.decode(source) as Map<String, dynamic>);
}
