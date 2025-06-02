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

  Stream<List<(Todo, Set<Tag>, Set<Image>)>> watchAllTodos() {
    final JoinedSelectStatement<HasResultSet, dynamic> query = _localDatabase
        .select(_localDatabase.todos)
        .join([
          leftOuterJoin(
            _localDatabase.todosAndTags,
            _localDatabase.todosAndTags.todoId.equalsExp(
              _localDatabase.todos.id,
            ),
          ),
          leftOuterJoin(
            _localDatabase.tags,
            _localDatabase.tags.id.equalsExp(_localDatabase.todosAndTags.tagId),
          ),
          leftOuterJoin(
            _localDatabase.images,
            _localDatabase.images.todoId.equalsExp(_localDatabase.todos.id),
          ),
        ]);

    return query.watch().map((rows) {
      final Map<int, (Todo, Set<Tag>, Set<Image>)> groupedMap = {};

      for (final row in rows) {
        final Todo todo = row.readTable(_localDatabase.todos);
        final Tag? tag = row.readTableOrNull(_localDatabase.tags);
        final Image? image = row.readTableOrNull(_localDatabase.images);

        final entry = groupedMap.putIfAbsent(
          todo.id,
          () => (todo, <Tag>{}, <Image>{}),
        );

        if (tag != null) {
          entry.$2.add(tag);
        }
        if (image != null) {
          entry.$3.add(image);
        }
      }

      return groupedMap.values.toList();
    });
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

  Future<bool> deleteTodosAndTagsByTodoId(int todoId) async {
    try {
      await (_localDatabase.delete(_localDatabase.todosAndTags)
        ..where((tbl) => tbl.todoId.equals(todoId))).go();

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

  Future<bool> deleteImage(int id) async {
    try {
      await (_localDatabase.delete(_localDatabase.images)
        ..where((item) => item.id.equals(id))).go();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteImageByTodoId(int todoId) async {
    try {
      await (_localDatabase.delete(_localDatabase.images)
        ..where((item) => item.todoId.equals(todoId))).go();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTodo(TodosCompanion todo) async {
    try {
      await _localDatabase.update(_localDatabase.todos).replace(todo);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await (_localDatabase.delete(_localDatabase.todos)
        ..where((item) => item.id.equals(id))).go();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertTempTodo(TempTodosCompanion tempTodo) async {
    try {
      await _localDatabase.into(_localDatabase.tempTodos).insert(tempTodo);

      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<int>> getAllTempTodoIds() {
    return _localDatabase
        .select(_localDatabase.tempTodos)
        .watch()
        .map((rows) => rows.map((row) => row.todoId).toList());
  }

  Future printTable() async {
    await _localDatabase.todos.select().get().then((todos) {
      print('Todos: $todos');
    });

    await _localDatabase.todosAndTags.select().get().then((todosAndTags) {
      print('TodosAndTags:$todosAndTags');
    });

    await _localDatabase.images.select().get().then((images) {
      print('Images:$images');
    });

    await _localDatabase.tempTodos.select().get().then((tempTodos) {
      print('TempTodos:$tempTodos');
    });
  }

  Future<T> runInTransaction<T>(Future<T> Function() action) async {
    return await _localDatabase.transaction(action);
  }
}
