import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_database_notifier.g.dart';

@Riverpod(keepAlive: false)
Stream<Set<Tag>> watchAllTags(Ref ref) async* {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  yield* repository.watchAllTags();
}

@Riverpod(keepAlive: false)
Stream<List<int>> watchAllTempTodoIds(Ref ref) async* {
  final LocalDatabaseRepository repository = GetIt.I<LocalDatabaseRepository>();

  yield* repository.watchAllTempTodoIds();
}
