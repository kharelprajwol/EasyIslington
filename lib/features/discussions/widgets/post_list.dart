import 'package:flutter/material.dart';
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
        return PostListItem(
          title: post.title,
          author: post.author,
          date: post.date,
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => PostScreen(),
          //     ),
          //   );
          // },
        );
      },
    );
  }
}
