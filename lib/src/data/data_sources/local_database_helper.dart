import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';

class LocalDatabaseHelper {
  late final LocalDatabase _localDatabase;

  LocalDatabaseHelper(LocalDatabase localDatabase)
    : _localDatabase = localDatabase;

  Future<bool> deleteTag(int id) async {
    int deleteID =
        await (_localDatabase.delete(_localDatabase.tags)
          ..where((item) => item.id.equals(id))).go();

    return deleteID != 0;
  }
}
