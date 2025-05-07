import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

final now = DateTime.now();

Task task = Task(isDone: false, id: "1", title: "First", createdDate: now);
Task toggledTask = Task(isDone: true, id: "1", title: "First", createdDate: now);

List<Task> tasks = [
  task,
  Task(isDone: false, id: "2", title: "Second", createdDate: now),
  Task(isDone: true, id: "3", title: "Third", createdDate: now.subtract(Duration(days: 1))),
  Task(isDone: false, id: "4", title: "4th Task", createdDate: now.add(Duration(days: 2))),
  Task(isDone: true, id: "5", title: "5th Task", createdDate: now),
];

void main() {
  group("Toggling Task's State", () {
    /// Success
    test('should return toggledTask when toggleStatus is successful', () async {
      final result = task.toggleStatus();

      expect(result.id, toggledTask.id);
      expect(result.isDone, toggledTask.isDone);
    });
  });
}
