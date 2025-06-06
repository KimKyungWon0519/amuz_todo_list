import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_database_notifier.g.dart';

@Riverpod(keepAlive: false)
Stream<Set<Tag>> watchAllTags(Ref ref) async* {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  yield* repository.watchAllTags();
}

@Riverpod(keepAlive: false)
Future<Set<Tag>> getAllTags(Ref ref) {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  return repository.getAllTags();
}

@Riverpod(keepAlive: false)
Stream<List<Todo>> watchAllTempTodoIds(Ref ref) async* {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  yield* repository.watchAllTempTodoIds();
}

@Riverpod(keepAlive: false)
Future<List<int>> getAllTempTodoIds(Ref ref) {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  return repository.getAllTempTodoIds();
}

@Riverpod(keepAlive: false)
Future<bool> deleteTempTodo(Ref ref, Todo todo) {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  return repository.deleteTempTodo(todo);
}

@Riverpod(keepAlive: false)
Future<bool> saveTempTodo(Ref ref, Todo todo) {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  return repository.insertTempTodo(todo);
}