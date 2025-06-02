import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';

abstract interface class LocalDatabaseRepository {
  Future<Set<Tag>> getAllTags();
  Stream<Set<Tag>> watchAllTags();
  Future<bool> deleteTag(Tag tag);
  Future<bool> deleteAllTag();
  Future<bool> addTag(Tag tag);

  Future<int> insertTodo(Todo todo);
  Future<bool> changeisDoneState(Todo todo);
  Future<bool> editTodo(Todo todo);
  Future<bool> deleteTodo(Todo todo);
  Stream<List<Todo>> watchAllTodos();

  Future<bool> insertTempTodo(Todo todo);
  Future<List<int>> getAllTempTodoIds();
}
