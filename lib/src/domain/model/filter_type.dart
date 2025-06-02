import 'package:amuz_todo_list/src/domain/model/tag.dart';

sealed class FilterType {
  String get name;

  const FilterType._();

  @override
  String toString() => name;
}

class AllFilterType extends FilterType {
  const AllFilterType() : super._();

  @override
  String get name => '전체';
}

class IncompleteFilterType extends FilterType {
  const IncompleteFilterType() : super._();

  @override
  String get name => '미완료';
}

class CompleteFilterType extends FilterType {
  const CompleteFilterType() : super._();

  @override
  String get name => '완료';
}

class TagFilterType extends FilterType {
  final Tag? tag;

  const TagFilterType(this.tag) : super._();

  @override
  String get name => tag?.name ?? '';
}
