import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int? id,
    required String title,
    required Set<Tag> tags,
    required List<String> images,
    required DateTime createAt,
    required DateTime? updateAt,
  }) = _Todo;
}
