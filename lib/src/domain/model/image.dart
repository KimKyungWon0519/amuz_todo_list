import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';

@freezed
abstract class Image with _$Image {
  const factory Image({
    int? id,
    required url,
  }) = _Image;
}