import 'package:flutter/material.dart';
import 'package:easy_islington/features/discussions/models/comment.dart';
import 'package:google_fonts/google_fonts.dart';
import '../discussions_service.dart';
import 'comment_card.dart';

class PostScreen extends StatefulWidget {
  final String title;
  final String author;
  final String date;
  final String content;
  final List<Comment> comments; // List of comments
  final String postId; // Post ID

  PostScreen({
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.postId,
    required this.comments,
  });

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final DiscussionsService discussionsService = DiscussionsService();
  final _comments = <Comment>[];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _comments.addAll(widget.comments);
  }

  Future<void> addComment(String text) async {
    try {
      await discussionsService.addComment(
        postId: widget.postId,
        text: text,
        author: widget.author,
      );

      final newComment = Comment(
        author: widget.author,
        text: text,
        createdAt: DateTime.now(),
        // If there are other fields in the Comment model, provide them with appropriate values.
      );

      setState(() {
        _comments.add(newComment);
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment added successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding comment: $error')),
      );
    }
  }

  TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontFamily: 'Kalam',
                fontSize: 25,
              ),
            )),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Kalam',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Author: ${widget.author}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${widget.date}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Content:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.content,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.black),
            SizedBox(height: 20),
            Text(
              'Comments:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return CommentCard(
                    commenterName: comment.author,
                    comment: comment.text,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_commentController.text.isNotEmpty) {
                      await addComment(_commentController.text);
                      _commentController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
