import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String commenterName;
  final String comment;

  CommentCard({required this.commenterName, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              commenterName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(comment),
          ],
        ),
      ),
    );
  }
}
