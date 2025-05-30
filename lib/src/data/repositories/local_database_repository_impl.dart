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
}
