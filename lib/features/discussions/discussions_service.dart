import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/post.dart';

class DiscussionsService {
  final String baseUrl = "http://192.168.0.107:3000/api";

  Future<Map<String, dynamic>> createPost({
    required String specialization,
    required String title,
    required String content,
    required String author,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-post'),
      body: json.encode({
        'specialization': specialization,
        'title': title,
        'content': content,
        'author': author,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<Map<String, dynamic>> addComment({
    required String postId,
    required String text,
    required String author,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-comment'),
      body: json.encode({
        'postId': postId,
        'text': text,
        'author': author,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add comment');
    }
  }

  Future<List<Post>> fetchPosts(String specialization) async {
    final response =
        await http.get(Uri.parse('$baseUrl/get-posts/$specialization'));

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> postsData = responseData['posts'];

      final List<Post> posts =
          postsData.map((data) => Post.fromJson(data)).toList();
      return posts;
    } else {
      throw Exception('Failed to get posts');
    }
  }
}
