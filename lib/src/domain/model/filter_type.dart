enum FilterType {
  all('전체'),
  incomplete('미완료'),
  complete('완료');

  final String name;
  const FilterType(this.name);
}