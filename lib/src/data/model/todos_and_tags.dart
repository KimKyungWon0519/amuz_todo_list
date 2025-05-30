import 'package:amuz_todo_list/src/data/model/tags.dart';
import 'package:amuz_todo_list/src/data/model/todos.dart';
import 'package:drift/drift.dart';

class TodosAndTags extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get todoId => integer().references(Todos, #id)();
  IntColumn get tagId => integer().references(Tags, #id)();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {todoId, tagId},
  ];
}
