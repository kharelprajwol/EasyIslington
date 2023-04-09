// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'comment.dart';

class Post {
  final String id;
  final String title;
  final String body;
  final String author;
  final String date;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.date,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'author': author,
      'date': date,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      author: map['author'] as String,
      date: map['date'] as String,
      comments: List<Comment>.from(
        (map['comments'] as List<int>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
