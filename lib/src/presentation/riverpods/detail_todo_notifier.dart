import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_todo_notifier.g.dart';

@Riverpod(keepAlive: false)
class DetailTodoNotifier extends _$DetailTodoNotifier {
  late final LocalDatabaseRepository _localDatabaseRepository;

  DetailTodoNotifier()
    : _localDatabaseRepository = GetIt.I<LocalDatabaseRepository>();

  @override
  Todo build() {
    return Todo.empty();
  }

  Future<bool> addTag(String name) {
    if (name.isEmpty) {
      return Future.value(false);
    }

    final Tag tag = Tag(name: name);

    return _localDatabaseRepository.addTag(tag);
  }

  Future<bool> deleteTag(Tag tag) {
    return _localDatabaseRepository.deleteTag(tag);
  }
}
