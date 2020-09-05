import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';

class PlaceholderService {
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  final _success = 200;

  Future<List<Post>> get posts async {
    final response = await http.get('$baseUrl/posts');

    if (response.statusCode == _success) {
      final json = jsonDecode(response.body) as List;

      return json.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Unable to receive posts ');
    }
  }

  Future<User> get profile async {
    final response = await http.get('$baseUrl/users/1');

    if (response.statusCode == _success) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unable to receive Profile');
    }
  }

  Future<List<Comment>> getComments(int postId) async {
    final response = await http.get('$baseUrl/posts/$postId/comments');
    if (response.statusCode == _success) {
      final json = jsonDecode(response.body) as List;
      return json.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception('Unable to receive Comments');
    }
  }
}
