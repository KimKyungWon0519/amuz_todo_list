import 'package:amuz_todo_list/src/data/data_sources/local_database.dart'
    as Data;
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;

extension DataTagsExension on Data.Tag {
  Domain.Tag toDomainModel() {
    return Domain.Tag(id: id, name: name);
  }
}
