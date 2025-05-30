import 'package:amuz_todo_list/src/data/data_sources/local_database_helper.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  late final LocalDatabaseHelper _localDatabaseHelper;

  LocalDatabaseRepositoryImpl(LocalDatabaseHelper localDatabaseHelper)
    : _localDatabaseHelper = localDatabaseHelper;

  @override
  Future<bool> deleteAllTag() {
    return _localDatabaseHelper.deleteAllTag();
  }

  @override
  Future<bool> deleteTag(Tag tag) {
    return _localDatabaseHelper.deleteTag(tag.id ?? 0);
    }

  @override
  Future<bool> addTag(Tag tag) {
    return _localDatabaseHelper.insertTag(tag);
  }
}
