import 'package:amuz_todo_list/src/domain/model/image.dart';
import 'package:amuz_todo_list/src/domain/model/tag.dart';
import 'package:amuz_todo_list/src/domain/model/todo.dart';
import 'package:amuz_todo_list/src/domain/repositories/local_database_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'write_todo_notifier.g.dart';

@Riverpod(keepAlive: false)
class WriteTodoNotifier extends _$WriteTodoNotifier {
  late final LocalDatabaseRepository _localDatabaseRepository;

  WriteTodoNotifier()
    : _localDatabaseRepository = GetIt.I<LocalDatabaseRepository>();

  @override
  WriteTodoState build() {
    return WriteTodoState(todo: Todo.empty());
  }

  void setTodo(Todo todo) {
    state = state.copyWith(todo: todo);
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
    state = state.copyWith(selectedImage: image);
  }

  void selectImage(Image image) {
    state = state.copyWith(selectedImage: image);
  }

  void deleteImage(Image image) {
    Todo todo = state.todo.copyWith(
      images: state.todo.images.toList()..remove(image),
    );

    if (state.selectedImage == image) {
      state = state.removeSelectedImage();
    }

    state = state.copyWith(todo: todo);
  }

  Future<bool> createTodo() {
    Todo todo = state.todo;

    return _localDatabaseRepository.insertTodo(todo);
  }

  Future<bool> editTodo(Todo todo) {
    return _localDatabaseRepository.editTodo(todo);
  }
}

class WriteTodoState {
  final Todo todo;
  final Image? selectedImage;

  WriteTodoState({required this.todo, this.selectedImage});

  WriteTodoState copyWith({Todo? todo, Image? selectedImage}) {
    return WriteTodoState(
      todo: todo ?? this.todo,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }

  WriteTodoState removeSelectedImage() {
    return WriteTodoState(todo: todo, selectedImage: null);
  }
}
