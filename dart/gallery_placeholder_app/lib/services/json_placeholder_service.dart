import 'dart:convert';

import 'package:gallery_placeholder_app/models/album.dart';
import 'package:gallery_placeholder_app/models/picture.dart';
import 'package:http/http.dart' as Http;

class JsonPlaceholderService {
  final _defaultUser = 1;
  final _baseURL = 'https://jsonplaceholder.typicode.com';
  final _success = 200;

  Future<List<Album>> get albums async {
    final response = await Http.get('$_baseURL/users/$_defaultUser/albums');

    if (response.statusCode == _success) {
      final json = jsonDecode(response.body) as List;

      return json.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Unable do get albums');
    }
  }

  Future<List<Picture>> getPictures(int albumIndex) async {
    final response = await Http.get('$_baseURL/albums/$albumIndex/photos');

    if (response.statusCode == _success) {
      final json = jsonDecode(response.body) as List;

      return json.map((e) => Picture.fromJson(e)).toList();
    } else {
      throw Exception('Unable do get albums');
    }
  }
}
