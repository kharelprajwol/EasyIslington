import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../discussions_service.dart';
import '../widgets/create_post_screen.dart';
import '../widgets/post_list.dart';
import '../widgets/post_list_item.dart';
import '../widgets/post_screen.dart';
import '../models/post.dart'; // Import the Post model
import '../discussions_service.dart'; // Import the DiscussionsService

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final DiscussionsService discussionsService = DiscussionsService();
  List<Post> posts = []; // List to store fetched posts

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final List<Post> fetchedPosts =
          await discussionsService.fetchPosts('Computer');
      setState(() {
        posts = fetchedPosts;
      });
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(
                            title: post.title,
                            author: post.author,
                            date:
                                DateFormat('yyyy-MM-dd').format(post.createdAt),
                            content: post.content,
                            comments: post.comments, // Pass the comments list
                            postId: post.id, // Pass the post ID
                          ),
                        ),
                      );
                    },
                    child: PostListItem(
                      title: post.title,
                      author: post.author,
                      date: DateFormat('yyyy-MM-dd').format(post.createdAt),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
