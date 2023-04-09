import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {
  final String body;
  final String author;
  final String date;

  const CommentListItem({
    Key? key,
    required this.body,
    required this.author,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(body),
      subtitle: Text('Author: $author - Date: $date'),
    );
  }
}
