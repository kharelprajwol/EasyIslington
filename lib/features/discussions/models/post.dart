import 'comment.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final commentsList = json['comments'] as List;
    final comments = commentsList.map((commentJson) {
      return Comment.fromJson(commentJson);
    }).toList();

    return Post(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
      comments: comments,
    );
  }
}
