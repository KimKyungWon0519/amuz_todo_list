import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart' as Domain;
import 'package:amuz_todo_list/src/domain/model/image.dart' as Domain;
import 'package:amuz_todo_list/src/domain/model/tag.dart' as Domain;
import 'package:drift/drift.dart';

extension DomainTableExtension on Domain.Todo {
  TodosCompanion toDataCompanion() {
    return TodosCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      title: Value(title),
      createDate: Value(createAt),
      updateDate: Value(updateAt),
      isDone: Value(isDone),
    );
  }
}

extension DataTodoExtension on Todo {
  Domain.Todo toDomainModel({required Set<Domain.Tag> tags, required List<Domain.Image> images}) {
    return Domain.Todo(
      id: id,
      title: title,
      createAt: createDate,
      updateAt: updateDate,
      tags: tags,
      images: images,
      isDone: isDone,
    );
  }
}