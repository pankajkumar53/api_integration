import 'package:api_integration/main.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (context, state) => Home(),
    ),

    GoRoute(
      path: AppRoutes.addPost,
      name: AppRoutes.addPost,
      builder: (context, state) => AddPost(),
    )

  ],
);

class AppRoutes {
  static const String home = "/home";
  static const String addPost = "/add_post";
}
