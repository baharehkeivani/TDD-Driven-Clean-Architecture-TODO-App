import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

import '../../../../core/datasource/local_datasource.dart';

@LazySingleton()
class TasksDatasource extends LocalDatasource<Task> {
  Box<Task>? box;

  TasksDatasource() {
    _initializeBox();
  }

  Future<void> _initializeBox() async {
    box = await Hive.openBox<Task>('Tasks');
  }

  @override
  Future<List<Task>> getAll() async {
    if (box == null) await _initializeBox();
    return box?.values.toList() ?? [];
  }

  @override
  Future<Task?> add(Task task) async {
    if (box == null) await _initializeBox();
    await box?.put(task.id, task);
    return task;
  }

  @override
  Future<void> remove(String id) async {
    if (box == null) await _initializeBox();
    return box?.delete(id);
  }

  @override
  Future<Task?> getById(String id) async {
    if (box == null) await _initializeBox();
    return box?.get(id);
  }

  @override
  Future<void> edit(Task newTask, bool Function(Task task) where) async {
    if (box == null) await _initializeBox();
    final i = box!.values.toList().indexWhere((item) => where.call(item));
    if (i == -1) throw Exception("No task found");
    await box!.putAt(i, newTask);
  }
}
