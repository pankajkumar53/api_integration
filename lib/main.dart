import 'package:api_integration/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: ApiService().getPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (!snapshot.hasData) {
                  return Text("No data");
                }

                final posts = snapshot.data as List<dynamic>;

                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                post["title"],
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),

                              Text(
                                post["body"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.addPost);
              },
              child: Text("Add Post"),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: "User ID",
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                ApiService().createPost(
                  _userIdController.text,
                  _titleController.text,
                  _bodyController.text,
                );
              },
              child: Text("Create Post"),
            ),
          ],
        ),
      ),
    );
  }
}
