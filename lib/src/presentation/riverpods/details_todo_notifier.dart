import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'details_todo_notifier.g.dart';

@Riverpod(keepAlive: false)
class DetailsTodoNotifier extends _$DetailsTodoNotifier {
  Todo build() {
    return Todo.empty();
  }
}