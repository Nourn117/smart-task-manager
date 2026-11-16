import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task_manager/data/models/task_dto.dart';
import 'package:smart_task_manager/data/models/task_dto_mapper.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';

void main() {
  group('fromJson', () {
    test('parses a DummyJSON todo', () {
      final dto = TaskDto.fromJson({
        'id': 1,
        'todo': 'Buy milk',
        'completed': true,
        'userId': 26,
      });

      expect(dto, const TaskDto(id: 1, title: 'Buy milk', completed: true));
    });

    test('throws FormatException for malformed JSON', () {
      expect(
        () => TaskDto.fromJson({'id': '1', 'todo': 'Buy milk'}),
        throwsFormatException,
      );
    });
  });

  test('maps to a synced local record with the remote id', () {
    final now = DateTime(2026, 5);

    final companion = const TaskDto(
      id: 7,
      title: 'Buy milk',
      completed: false,
    ).toCompanion(localId: 'local-1', now: now);

    expect(companion.id.value, 'local-1');
    expect(companion.remoteId.value, 7);
    expect(companion.title.value, 'Buy milk');
    expect(companion.syncStatus.value, SyncStatus.synced);
    expect(companion.createdAt.value, now);
  });
}
