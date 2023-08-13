import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import '../models/post.dart';
import 'post_list_item.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  PostList({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final formattedDate =
            DateFormat('yyyy-MM-dd').format(post.createdAt); // Format the date
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 3, // Add elevation for a subtle shadow
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PostListItem(
                title: post.title,
                author: post.author,
                date: formattedDate, // Use the formatted date
              ),
            ),
          ),
        );
      },
    );
  }
}
