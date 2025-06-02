import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'details_todo_notifier.g.dart';

@Riverpod(keepAlive: false)
class DetailsTodoNotifier extends _$DetailsTodoNotifier {
  late final LocalDatabaseRepository _localDatabaseRepository;

  DetailsTodoNotifier()
    : _localDatabaseRepository = GetIt.I<LocalDatabaseRepository>();

  @override
  Todo build() {
    return Todo.empty();
  }

  void updateTodo(Todo todo) {
    state = todo;
  }

  void changeDoneState(Todo todo, bool isDone) {
    final updatedTodo = todo.copyWith(isDone: isDone);

    state = updatedTodo;

    _localDatabaseRepository.updateTodo(updatedTodo).then((value) {
      if (!value) {
        state = todo;
      }
    });
  }
}
