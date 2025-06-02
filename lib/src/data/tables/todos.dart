import 'package:amuz_todo_list/src/core/constants/app_constant.dart';
import 'package:drift/drift.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: todoTitleMaxLength)();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createDate => dateTime()();
  DateTimeColumn get updateDate => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime()();
}
