import 'package:flutter/material.dart';

import 'comment_card.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<String> comments = [
    'Thanks for sharing this post!',
    'I had a similar issue. Did you try restarting the server?',
    'Great post! Very helpful information.',
    'Comment 1',
    'Comment 2',
    'Comment 3',
    'Comment 4',
    'Comment 5',
    'Comment 6',
    'Comment 7',
  ];

  void addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: MSQL not working',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Author: Prajwol Kharel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Date: 2022-02-25',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
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
              'I\'m having trouble with MSQL database connections. Whenever I try to connect...',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.black),
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
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentCard(
                    commenterName:
                        'John Doe', // Replace with actual commenter name
                    comment: comments[index],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            CommentForm(onCommentAdded: addComment),
          ],
        ),
      ),
    );
  }
}

class CommentForm extends StatefulWidget {
  final Function(String) onCommentAdded;

  CommentForm({required this.onCommentAdded});

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: () {
            if (_commentController.text.isNotEmpty) {
              widget.onCommentAdded(_commentController.text);
              _commentController.clear();
            }
          },
          child: Text('Add'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
