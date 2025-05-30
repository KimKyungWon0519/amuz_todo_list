import 'package:amuz_todo_list/src/data/data_sources/local_database_helper.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  late final LocalDatabaseHelper _localDatabaseHelper;

  LocalDatabaseRepositoryImpl(LocalDatabaseHelper localDatabaseHelper)
    : _localDatabaseHelper = localDatabaseHelper;

  @override
  Future<bool> addTag(Tag tag) {
    // TODO: GetTagOnce 메소드 생성 후 중복 확인 코드 추가

    return _localDatabaseHelper.insertTag(tag);
  }
}
