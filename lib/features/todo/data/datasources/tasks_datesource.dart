import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

import '../../../../core/datasource/local_datasource.dart';

@LazySingleton()
final class TasksDatasource extends LocalDatasource<Task> {
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
  Future<int?> add(Task task) async {
    if (box == null) await _initializeBox();
    return box?.add(task);
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
}
