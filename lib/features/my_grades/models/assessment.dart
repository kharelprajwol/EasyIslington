// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Assessment {
  final String id;
  final String name;
  final int weight;
  final int mark;

  Assessment(
      {required this.id,
      required this.name,
      required this.weight,
      required this.mark});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'weight': weight,
      'mark': mark,
    };
  }

  factory Assessment.fromMap(Map<String, dynamic> map) {
    return Assessment(
      id: map['_id'] as String,
      name: map['name'] as String,
      weight: map['weight'] as int,
      mark: map['mark'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assessment.fromJson(String source) =>
      Assessment.fromMap(json.decode(source) as Map<String, dynamic>);
}
