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
  Future<bool> insertTodo(Domain.Todo todo) {
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

          return true;
        })
        .catchError((_) => false);
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
  Future<bool> updateTodo(Domain.Todo todo) {
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

          for (final Domain.Image image in todo.images) {
            isSuccess = await _localDatabaseHelper.deleteImage(image.id!);

            if (!isSuccess) throw Exception('Failed to delete image');
          }

          isSuccess = await _localDatabaseHelper.deleteTodo(todo.id!);

          if (!isSuccess) throw Exception('Failed to delete todos and tags');

          return true;
        })
        .catchError((_) => false);
  }
}
