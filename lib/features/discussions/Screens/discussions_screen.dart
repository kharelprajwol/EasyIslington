import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../providers/student_provider.dart';
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
      final studentSpecialization =
          Provider.of<StudentProvider>(context, listen: false)
              .student
              .specialization;

      final List<Post> fetchedPosts =
          await discussionsService.fetchPosts(studentSpecialization);
      setState(() {
        posts = fetchedPosts;
      });
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  void refreshPosts() {
    setState(() {
      fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentSpecialization =
        Provider.of<StudentProvider>(context).student.specialization;

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontFamily: 'Kalam',
                fontSize: 30,
              ),
            )),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Note: These following posts are of your specialization; $studentSpecialization. If you want to view the posts of other specializations, please update your profile.',
                style: TextStyle(
                  fontFamily: 'Kalam',
                  color: Colors.black, // Giving it a red color for emphasis
                  fontSize: 14,
                ),
              ),
            ),
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
              builder: (context) => CreatePostScreen(refresh: refreshPosts),
            ),
          );
        },
        backgroundColor: Colors.blue.shade600,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
