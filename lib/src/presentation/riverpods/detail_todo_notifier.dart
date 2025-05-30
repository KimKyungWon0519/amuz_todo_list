import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_todo_notifier.g.dart';

@Riverpod(keepAlive: false)
class DetailTodoNotifier extends _$DetailTodoNotifier {
  @override
  Todo build() {
    return Todo.empty();
  }
}