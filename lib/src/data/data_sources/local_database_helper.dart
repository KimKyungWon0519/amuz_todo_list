import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;

class LocalDatabaseHelper {
  late final LocalDatabase _localDatabase;

  LocalDatabaseHelper(LocalDatabase localDatabase)
    : _localDatabase = localDatabase;

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
