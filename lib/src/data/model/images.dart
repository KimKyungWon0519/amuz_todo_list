import 'package:amuz_todo_list/src/data/model/todos.dart';
import 'package:drift/drift.dart';

class Images extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get todoId => integer().references(Todos, #id)();
  TextColumn get url => text()();
}
