import 'package:amuz_todo_list/src/domain/model/filter_type.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  late final LocalDatabaseRepository _localDatabaseRepository;

  FilterType _filterType = AllFilterType();

  TodoListNotifier()
    : _localDatabaseRepository = GetIt.I<LocalDatabaseRepository>();

  @override
  Stream<List<Todo>> build() {
    return _localDatabaseRepository.watchAllTodos();
  }

  void changeDoneState(Todo todo, bool isDone) {
    final updatedTodo = todo.copyWith(isDone: isDone);

    AsyncValue<List<Todo>> todos = state;

    _localDatabaseRepository.changeisDoneState(updatedTodo).then((value) {
      value ? applyFilter(_filterType) : state = todos;
    });
  }

  void deleteTodo(Todo todo) {
    AsyncValue<List<Todo>> todos = state;

    if (todos.hasValue) {
      final List<Todo> updatedTodos = todos.value!.toList();

      updatedTodos.removeWhere((element) => element.id == todo.id);

      state = AsyncValue.data(updatedTodos);
    }

    _localDatabaseRepository.deleteTodo(todo).then((value) {
      if (!value) {
        state = todos;
      }
    });
  }

  void applyFilter(FilterType filterType) async {
    _filterType = filterType;

    List<Todo> todos = await _localDatabaseRepository.getAllTodos();

    switch (filterType) {
      case AllFilterType():
        state = AsyncData(todos);
        break;
      case IncompleteFilterType():
        state = AsyncData(todos.where((todo) => !todo.isDone).toList());
        break;
      case CompleteFilterType():
        state = AsyncData(todos.where((todo) => todo.isDone).toList());
        break;
      case TagFilterType():
        state = AsyncData(
          todos.where((todo) => todo.tags.contains(filterType.tag)).toList(),
        );
        break;
    }
  }
}
