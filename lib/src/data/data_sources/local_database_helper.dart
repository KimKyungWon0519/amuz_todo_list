import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:drift/drift.dart';

class LocalDatabaseHelper {
  late final LocalDatabase _localDatabase;

  LocalDatabaseHelper(LocalDatabase localDatabase)
    : _localDatabase = localDatabase;

  Future<List<Tag>> getAllTags() async {
    return await _localDatabase.select(_localDatabase.tags).get();
  }

  Stream<List<Tag>> watchAllTags() {
    return _localDatabase.select(_localDatabase.tags).watch();
  }

  Future<Tag?> getTagOrNullByName(String name) async {
    return (_localDatabase.select(_localDatabase.tags)
      ..where((item) => item.name.equals(name))).getSingleOrNull();
  }

  Future<bool> deleteTag(int id) async {
    int deleteID =
        await (_localDatabase.delete(_localDatabase.tags)
          ..where((item) => item.id.equals(id))).go();

    return deleteID != 0;
  }

  Future<bool> deleteAllTag() async {
    int deleteID = await _localDatabase.delete(_localDatabase.tags).go();

    return deleteID != 0;
  }

  Future<bool> insertTag(TagsCompanion tagsCompanion) async {
    try {
      await _localDatabase.into(_localDatabase.tags).insert(tagsCompanion);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> insertTodo(TodosCompanion todo) async {
    try {
      return await _localDatabase.into(_localDatabase.todos).insert(todo);
    } catch (e) {
      return -1;
    }
  }

  Future<bool> insertTodosAndTags(
    TodosAndTagsCompanion todosAndTagsCompanion,
  ) async {
    try {
      await _localDatabase
          .into(_localDatabase.todosAndTags)
          .insert(todosAndTagsCompanion);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertImage(ImagesCompanion image) async {
    try {
      await _localDatabase.into(_localDatabase.images).insert(image);

      return true;
    } catch (e) {
      return false;
    }
  }


  Future<List<Tag>> getAllTagsByTodoId(int todoId) async {
    final List<TypedResult> result = await (_localDatabase.select(_localDatabase.tags).join([
      innerJoin(
        _localDatabase.todosAndTags,
        _localDatabase.todosAndTags.tagId.equalsExp(_localDatabase.tags.id),
      ),
    ])..where(_localDatabase.todosAndTags.todoId.equals(todoId))).get();

    return result.map((row) => row.readTable(_localDatabase.tags)).toList();
  }

  Future<T> runInTransaction<T>(Future<T> Function() action) async {
    return await _localDatabase.transaction(action);
  }
}
