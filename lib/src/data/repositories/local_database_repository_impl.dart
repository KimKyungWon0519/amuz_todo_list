import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/data/data_sources/local_database_helper.dart';
import 'package:amuz_todo_list/src/data/mapper/tag_mapper.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';

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

    return _localDatabaseHelper.insertTag(tag);
  }

  @override
  Stream<Set<Domain.Tag>> watchAllTags() {
    return _localDatabaseHelper.watchAllTags().map((tags) {
      return tags.map((e) => e.toDomainModel()).toSet();
    });
  }
}
