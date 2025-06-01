import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart' as Domain;

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
      await _localDatabase
          .into(_localDatabase.tags)
          .insert(tagsCompanion);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertTodo(Domain.Todo todo) async {
    try {
      await _localDatabase
          .into(_localDatabase.todos)
          .insert(
            TodosCompanion.insert(
              title: todo.title,
              createDate: todo.createAt,
            ),
          );
      return true;
    } catch (e) {
      return false;
    }
  }
}
