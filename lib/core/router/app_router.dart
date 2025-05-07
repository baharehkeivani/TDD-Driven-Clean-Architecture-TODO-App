import 'package:go_router/go_router.dart';

import '../../features/todo/presentation/pages/tasks_list_page.dart';

class AppRouter {
  AppRouter._();

  static final AppRouter instance = AppRouter._();

  factory AppRouter() => instance;

  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: TasksListPage.path,
        name: TasksListPage.name,
        builder: (context, state) => TasksListPage.wrapper(),
      ),
    ],
  );
}
