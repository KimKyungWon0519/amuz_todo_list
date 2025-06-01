import 'package:amuz_todo_list/src/data/data_sources/local_database.dart'
    as Data;
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;
import 'package:drift/drift.dart';

extension DataTagsExension on Data.Tag {
  Domain.Tag toDomainModel() {
    return Domain.Tag(id: id, name: name);
  }
}

extension DomainTagsExtension on Domain.Tag {
  Data.TagsCompanion toDataCompanion() {
    return Data.TagsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
    );
  }
}
