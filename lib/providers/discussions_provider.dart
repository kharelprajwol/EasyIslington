import 'package:flutter/foundation.dart';
import 'package:easy_islington/features/discussions/models/comment.dart';
import 'package:easy_islington/features/discussions/discussions_service.dart';

import '../features/discussions/models/post.dart';

class DiscussionsProvider with ChangeNotifier {
  List<Post> _posts = [];
  Map<String, List<Comment>> _comments = {};
  final DiscussionsService _discussionsService = DiscussionsService();

  List<Post> get posts => _posts;
  List<Comment> getCommentsForPost(String postId) => _comments[postId] ?? [];

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  void addCommentToPost(String postId, Comment comment) {
    if (!_comments.containsKey(postId)) {
      _comments[postId] = [];
    }
    _comments[postId]!.add(comment);
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    try {
      final List<Post> fetchedPosts =
          await _discussionsService.fetchPosts('Computer');
      _posts = fetchedPosts;
      notifyListeners();
    } catch (error) {
      print('Error fetching posts: $error');
      // Handle error appropriately, maybe using another state variable
    }
  }

  // ... Other methods and fields...
}
