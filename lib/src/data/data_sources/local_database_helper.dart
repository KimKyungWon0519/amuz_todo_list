import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;

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

  Future<bool> insertTag(Domain.Tag tag) async {
    try {
      await _localDatabase
          .into(_localDatabase.tags)
          .insert(TagsCompanion.insert(name: tag.name));

      return true;
    } catch (e) {
      return false;
    }
  }
}
