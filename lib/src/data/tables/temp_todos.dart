import 'package:amuz_todo_list/src/data/tables/todos.dart';
import 'package:drift/drift.dart';

class TempTodos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get todoId => integer().references(Todos, #id)();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {todoId},
  ];
}
