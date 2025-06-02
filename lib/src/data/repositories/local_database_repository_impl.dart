import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/data/data_sources/local_database_helper.dart';
import 'package:amuz_todo_list/src/data/mapper/image_mapper.dart';
import 'package:amuz_todo_list/src/data/mapper/tag_mapper.dart';
import 'package:amuz_todo_list/src/data/mapper/todo_mapper.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;
import 'package:amuz_todo_list/src/domain/model/todo.dart' as Domain;
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:drift/drift.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  late final LocalDatabaseHelper _localDatabaseHelper;

  LocalDatabaseRepositoryImpl(LocalDatabaseHelper localDatabaseHelper)
    : _localDatabaseHelper = localDatabaseHelper;

  @override
  Future<Set<Domain.Tag>> getAllTags() async {
    List<Tag> tags = await _localDatabaseHelper.getAllTags();

    return tags.map((e) => e.toDomainModel()).toSet();
  }

  @override
  Future<bool> deleteAllTag() {
    return _localDatabaseHelper.deleteAllTag();
  }

  @override
  Future<bool> deleteTag(Domain.Tag tag) {
    return _localDatabaseHelper.deleteTag(tag.id ?? 0);
  }

  @override
  Future<bool> addTag(Domain.Tag tag) async {
    Tag? findTag = await _localDatabaseHelper.getTagOrNullByName(tag.name);

    if (findTag != null) return false;

    return _localDatabaseHelper.insertTag(tag.toDataCompanion());
  }

  @override
  Stream<Set<Domain.Tag>> watchAllTags() {
    return _localDatabaseHelper.watchAllTags().map((tags) {
      return tags.map((e) => e.toDomainModel()).toSet();
    });
  }

  @override
  Future<int> insertTodo(Domain.Todo todo) {
    return _localDatabaseHelper
        .runInTransaction(() async {
          int todoID = await _localDatabaseHelper.insertTodo(
            todo.toDataCompanion(),
          );

          if (todoID == -1) throw Exception('Failed to insert todo');

          for (final Domain.Tag tag in todo.tags) {
            bool isSuccess = await _localDatabaseHelper.insertTodosAndTags(
              TodosAndTagsCompanion(
                todoId: Value(todoID),
                tagId: Value(tag.id!),
              ),
            );

            if (!isSuccess) {
              throw Exception('Failed to insert todo and tag');
            }
          }

          for (final Domain.Image image in todo.images) {
            bool isSuccess = await _localDatabaseHelper.insertImage(
              image.toDataCompanion(todoID),
            );

            if (!isSuccess) {
              throw Exception('Failed to insert image');
            }
          }

          return todoID;
        })
        .catchError((_) => -1);
  }

  @override
  Stream<List<Domain.Todo>> watchAllTodos() {
    return _localDatabaseHelper.watchAllTodos().map((values) {
      return values.map((value) {
        final Set<Domain.Tag> tags =
            value.$2.map((tag) => tag.toDomainModel()).toSet();
        final List<Domain.Image> images =
            value.$3.map((image) => image.toDomainModel()).toList();
        final Domain.Todo todo = value.$1.toDomainModel(
          tags: tags,
          images: images,
        );

        return todo;
      }).toList();
    });
  }

  @override
  Future<bool> changeisDoneState(Domain.Todo todo) {
    return _localDatabaseHelper.updateTodo(todo.toDataCompanion());
  }

  @override
  Future<bool> deleteTodo(Domain.Todo todo) {
    if (todo.id == null) {
      return Future.value(false);
    }

    return _localDatabaseHelper
        .runInTransaction(() async {
          bool isSuccess = false;

          isSuccess = await _localDatabaseHelper.deleteTodosAndTagsByTodoId(
            todo.id!,
          );

          if (!isSuccess) throw Exception('Failed to delete todos and tags');

          isSuccess = await _localDatabaseHelper.deleteImageByTodoId(todo.id!);

          if (!isSuccess) throw Exception('Failed to delete image');

          isSuccess = await _localDatabaseHelper.deleteTodo(todo.id!);

          if (!isSuccess) throw Exception('Failed to delete todos and tags');

          return true;
        })
        .catchError((_) => false);
  }

  @override
  Future<bool> editTodo(Domain.Todo todo) {
    return _localDatabaseHelper
        .runInTransaction(() async {
          bool isSuccess = false;

          isSuccess = await _localDatabaseHelper.updateTodo(
            todo.toDataCompanion(),
          );

          if (!isSuccess) throw Exception('Failed to update todo');

          isSuccess = await _localDatabaseHelper.deleteTodosAndTagsByTodoId(
            todo.id!,
          );

          if (!isSuccess) throw Exception('Failed to delete todos and tags');

          isSuccess = await _localDatabaseHelper.deleteImageByTodoId(todo.id!);

          if (!isSuccess) throw Exception('Failed to delete image');

          for (final Domain.Tag tag in todo.tags) {
            bool isSuccess = await _localDatabaseHelper.insertTodosAndTags(
              TodosAndTagsCompanion(
                todoId: Value(todo.id!),
                tagId: Value(tag.id!),
              ),
            );

            if (!isSuccess) {
              throw Exception('Failed to insert todo and tag');
            }
          }

          for (final Domain.Image image in todo.images) {
            bool isSuccess = await _localDatabaseHelper.insertImage(
              image.toDataCompanion(todo.id!),
            );

            if (!isSuccess) {
              throw Exception('Failed to insert image');
            }
          }

          return true;
        })
        .catchError((_) => false);
  }

  @override
  Future<bool> insertTempTodo(Domain.Todo todo) {
    return _localDatabaseHelper
        .runInTransaction(() async {
          int todoId = await insertTodo(todo);

          if (todoId == -1) {
            throw Exception('Failed to insert todo');
          }

          bool isSuccess = await _localDatabaseHelper.insertTempTodo(
            TempTodosCompanion(todoId: Value(todoId)),
          );

          if (!isSuccess) {
            throw Exception('Failed to insert temp todo');
          }

          return true;
        })
        .catchError((_) => false);
  }

  @override
  Stream<List<Domain.Todo>> watchAllTempTodoIds() {
    return _localDatabaseHelper.watchAllTempTodoIds().map(
      (values) =>
          values
              .map((element) => element.toDomainModel(tags: {}, images: []))
              .toList(),
    );
  }

  @override
  Future<List<int>> getAllTempTodoIds() {
    return _localDatabaseHelper.getAllTempTodoIds();
  }

  @override
  Future<bool> deleteTempTodo(Domain.Todo todo) {
    return _localDatabaseHelper
        .runInTransaction(() async {
          if (todo.id == null) {
            return false;
          }

          bool isSuccess = await _localDatabaseHelper.deleteTempTodoByTodoId(
            todo.id!,
          );

          if (!isSuccess) {
            throw Exception('Failed to delete temp todo');
          }

          isSuccess = await deleteTodo(todo);

          if (!isSuccess) {
            throw Exception('Failed to delete todo');
          }

          return true;
        })
        .catchError((_) => false);
  }
}
