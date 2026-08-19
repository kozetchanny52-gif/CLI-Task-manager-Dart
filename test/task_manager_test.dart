import 'package:test/test.dart';
import 'package:task_manager/task.dart';

void main() {
  test('Task is created correctly', () {
    final task = Task(
      Type.normal,
      'Learn Dart testing',
      DateTime(2026, 8, 19),
      Priority.high,
      DateTime(2026, 8, 25),
      Status.pending,
    );

    expect(task.title, 'Learn Dart testing');
    expect(task.type, Type.normal);
    expect(task.priority, Priority.high);
    expect(task.status, Status.pending);
    expect(task.is_created, DateTime(2026, 8, 19));
    expect(task.deadline, DateTime(2026, 8, 25));
  });
}
