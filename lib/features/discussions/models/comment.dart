class Comment {
  final String text;
  final String author;
  final DateTime createdAt;

  Comment({
    required this.text,
    required this.author,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
