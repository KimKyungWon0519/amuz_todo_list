import 'package:amuz_todo_list/src/data/data_sources/local_database.dart';
import 'package:amuz_todo_list/src/data/repositories/local_database_repository_impl.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';

void initializeDependency() {
  final LocalDatabase localDatabase = LocalDatabase();

  final LocalDatabaseRepositoryImpl localDatabaseRepositoryImpl =
      LocalDatabaseRepositoryImpl(localDatabase);

  GetIt.I.registerLazySingleton<LocalDatabaseRepository>(
    () => localDatabaseRepositoryImpl,
  );
}
