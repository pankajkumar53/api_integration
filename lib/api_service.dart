import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseurl = "https://jsonplaceholder.typicode.com";

  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse("$baseurl/posts"));

    final body = response.body;

    final body1 = response.body;
    debugPrint(response.body);
    debugPrint(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception("Something went wrong");
  }

  Future<void> createPost(String userId, String title, String body) async {
    final response = await http.post(
      Uri.parse("$baseurl/posts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "title": title, "body": body}),
    );

    if (response.statusCode == 201) {
      debugPrint("✅ Post created successfully");
    } else {
      debugPrint("❌ Error creating post: ${response.statusCode}");
    }
  }
}
