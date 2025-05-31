import 'package:amuz_todo_list/src/domain/model/tag.dart';

abstract interface class LocalDatabaseRepository {
  Future<Set<Tag>> getAllTags();
  Stream<Set<Tag>> watchAllTags();
  Future<bool> deleteTag(Tag tag);
  Future<bool> deleteAllTag();
  Future<bool> addTag(Tag tag);
}
