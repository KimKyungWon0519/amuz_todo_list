import 'package:amuz_todo_list/src/domain/model/tag.dart';

abstract interface class LocalDatabaseRepository {
  Future<Set<Tag>> getAllTags();
}
