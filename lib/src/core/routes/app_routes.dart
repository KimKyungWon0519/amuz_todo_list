import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/presentation/pages/details_todo_page/details_todo_page.dart';
import 'package:amuz_todo_list/src/presentation/pages/shell_route_page/shell_route_page.dart';
import 'package:amuz_todo_list/src/presentation/pages/todo_list_page/todo_list_page.dart';
import 'package:amuz_todo_list/src/presentation/pages/user_page/user_page.dart';
import 'package:amuz_todo_list/src/presentation/pages/write_todo_page.dart/write_todo_page.dart';
import 'package:go_router/go_router.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute main = GoRoute(
    path: '/',
    builder: (context, state) => TodoListPage(),
  );

  static final GoRoute detailsTodo = GoRoute(
    path: '/details_todo',
    builder:
        (context, state) =>
            DetailsTodoPage(todo: state.extra as Todo? ?? Todo.empty()),
  );

  static final GoRoute user = GoRoute(
    path: '/user',
    builder: (context, state) => UserPage(),
  );

  static final GoRoute writeTodo = GoRoute(
    path: '/write_todo',
    builder: (context, state) {
      final Todo? todo = state.extra as Todo?;

      return WriteTodoPage(todo: todo);
    },
  );

  static final StatefulShellRoute shellRoute = StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(routes: [main]),
      StatefulShellBranch(routes: [user]),
    ],
    builder:
        (context, state, navigationShell) =>
            ShellRoutePage(state: state, navigationShell: navigationShell),
  );

  static final List<RouteBase> routes = [shellRoute, detailsTodo, writeTodo];
}
