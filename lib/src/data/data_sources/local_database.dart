import 'package:amuz_todo_list/src/data/model/images.dart';
import 'package:amuz_todo_list/src/data/model/tags.dart';
import 'package:amuz_todo_list/src/data/model/todos.dart';
import 'package:amuz_todo_list/src/data/model/todos_and_tags.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

@DriftDatabase(tables: [Todos, Tags, TodosAndTags, Images])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'local_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
