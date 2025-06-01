import 'package:amuz_todo_list/src/data/data_sources/local_database.dart'
    as Data;
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;
import 'package:drift/drift.dart';

extension DomainImageMapper on Domain.Image {
  Data.ImagesCompanion toDataCompanion(int todoId) {
    return Data.ImagesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      url: Value(url),
      todoId: Value(todoId),
    );
  }
}
