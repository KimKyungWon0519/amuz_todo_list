import 'package:amuz_todo_list/src/domain/model/image.dart';
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
  DetailTodoState build() {
    return DetailTodoState(todo: Todo.empty());
  }

  void setTitle(String title) {
    Todo todo = state.todo.copyWith(title: title);

    state = state.copyWith(todo: todo);
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

  void selectedTag(Tag tag) {
    Todo todo = state.todo.copyWith(tags: {...state.todo.tags, tag});

    state = state.copyWith(todo: todo);
  }

  void unselectedTag(Tag tag) {
    Todo todo = state.todo.copyWith(tags: state.todo.tags.toSet()..remove(tag));

    state = state.copyWith(todo: todo);
  }

  void addImage(Image image) {
    if (image.url.isEmpty) {
      return;
    }

    Todo todo = state.todo.copyWith(images: [...state.todo.images, image]);

    state = state.copyWith(todo: todo);
  }

  void selectImage(Image image) {
    state = state.copyWith(selectedImage: image);
  }

  void deleteImage(Image image) {
    Todo todo = state.todo.copyWith(
      images: state.todo.images.toList()..remove(image),
    );

    state = state.copyWith(todo: todo, selectedImage: null);
  }
}

class DetailTodoState {
  final Todo todo;
  final Image? selectedImage;

  DetailTodoState({required this.todo, this.selectedImage});

  DetailTodoState copyWith({Todo? todo, Image? selectedImage}) {
    return DetailTodoState(
      todo: todo ?? this.todo,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}
