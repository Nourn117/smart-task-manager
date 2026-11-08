import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';

/// A todo as returned by the DummyJSON API.
@Freezed(fromJson: false, toJson: false)
abstract class TaskDto with _$TaskDto {
  const factory TaskDto({
    required int id,
    required String title,
    required bool completed,
  }) = _TaskDto;

  /// Throws [FormatException] when [json] isn't a valid todo.
  factory TaskDto.fromJson(Map<String, dynamic> json) => switch (json) {
    {
      'id': final int id,
      'todo': final String title,
      'completed': final bool completed,
    } =>
      TaskDto(id: id, title: title, completed: completed),
    _ => throw FormatException('Unexpected todo JSON: $json'),
  };
}
