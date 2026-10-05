import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  const Post(this.title);
  final String title;
}

/// The caller owns the injected client and closes it when no longer needed.
class PostService {
  PostService(this.client);
  final http.Client client;

  Future<Post> fetchPost() async {
    final response = await client
        .get(Uri.https('jsonplaceholder.typicode.com', '/posts/1'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    if (data is! Map<String, dynamic> || data['title'] is! String) {
      throw const FormatException('Expected a JSON object with a title.');
    }
    return Post(data['title'] as String);
  }
}
