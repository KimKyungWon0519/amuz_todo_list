import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart' as Domain;
import 'package:drift/drift.dart';

extension DomainTableExtension on Domain.Todo {
  TodosCompanion toDataCompanion() {
    return TodosCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      title: Value(title),
      createDate: Value(createAt),
      updateDate: Value(updateAt),
    );
  }
}