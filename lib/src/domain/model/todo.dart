import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String title,
    required Set<String> tags,
    required List<String> images,
    required DateTime createAt,
    required DateTime? updateAt,
  }) = _Todo;
}
