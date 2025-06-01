import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  late final LocalDatabaseRepository _localDatabaseRepository;

  TodoListNotifier()
    : _localDatabaseRepository = GetIt.I<LocalDatabaseRepository>();

  @override
  Stream<List<Todo>> build() {
    return _localDatabaseRepository.watchAllTodos();
  }
}
