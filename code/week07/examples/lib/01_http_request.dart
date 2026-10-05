// WHAT YOU LEARN: http.Client, Uri, JSON, loading/error states and retry.
// HOW TO RUN: flutter run -t lib/01_http_request.dart
// EXPECTED RESULT: a loading indicator then a post title, or an error with Retry.
// Requires internet access. Tests inject a fake client and do not use the network.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'services/post_service.dart';

void main() => runApp(const HttpApp());

class HttpApp extends StatelessWidget {
  const HttpApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HttpPage());
}

class HttpPage extends StatefulWidget {
  const HttpPage({super.key, this.client});
  final http.Client? client;

  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  late final http.Client _client;
  late final PostService _service;
  late Future<Post> _post;

  @override
  void initState() {
    super.initState();
    _client = widget.client ?? http.Client();
    _service = PostService(_client);
    _post = _service.fetchPost();
  }

  @override
  void dispose() {
    if (widget.client == null) _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Week 7: http')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FutureBuilder<Post>(
              future: _post,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Could not load the post.'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _post = _service.fetchPost();
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  );
                }
                return Text(snapshot.data!.title);
              },
            ),
          ),
        ),
      );
}
