// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'module.dart';

class Year {
  final String id;
  final String year;
  final int weight;
  final List<Module> modules;

  Year(
      {required this.id,
      required this.year,
      required this.weight,
      required this.modules});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'weight': weight,
      'modules': modules.map((x) => x.toMap()).toList(),
    };
  }

  factory Year.fromMap(Map<String, dynamic> map) {
    return Year(
      id: map['_id'] as String,
      year: map['year'] as String,
      weight: map['weight'] as int,
      modules: List<Module>.from(
        (map['modules'] as List<dynamic>).map<Module>(
          (x) => Module.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Year.fromJson(String source) =>
      Year.fromMap(json.decode(source) as Map<String, dynamic>);
}
