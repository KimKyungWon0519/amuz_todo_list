import 'package:drift/drift.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: 100)();
  DateTimeColumn get createDate => dateTime()();
  DateTimeColumn get updateDate => dateTime().nullable()();
}
