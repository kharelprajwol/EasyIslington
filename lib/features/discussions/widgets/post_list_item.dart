import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  //final VoidCallback onTap;

  const PostListItem({
    Key? key,
    required this.title,
    required this.author,
    required this.date,
    //required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('Author: $author - Date: $date'),
      //onTap: onTap,
    );
  }
}
