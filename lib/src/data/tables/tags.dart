import 'package:amuz_todo_list/src/core/constants/app_constant.dart';
import 'package:drift/drift.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 0, max: tagMaxLength)();
}