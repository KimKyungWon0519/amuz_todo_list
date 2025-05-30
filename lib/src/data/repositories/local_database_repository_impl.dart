import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  late final LocalDatabase _localDatabase;

  LocalDatabaseRepositoryImpl(LocalDatabase localDatabase)
    : _localDatabase = localDatabase;
}
