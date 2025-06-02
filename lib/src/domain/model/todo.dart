import 'package:amuz_todo_list/src/domain/model/image.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    int? id,
    required String title,
    required Set<Tag> tags,
    required List<Image> images,
    required DateTime createAt,
    @Default(false) bool isDone,
    DateTime? updateAt,
    required DateTime dueDate,
  }) = _Todo;

  factory Todo.empty() =>
      Todo(title: '', tags: {}, images: [], createAt: DateTime.now(), dueDate: DateTime.now().add(const Duration(days: 1)));
}
