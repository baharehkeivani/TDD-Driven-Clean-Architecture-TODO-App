import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime createdDate;

  @HiveField(3)
  final bool isDone;

  Task({
    required this.isDone,
    required this.id,
    required this.title,
    required this.createdDate,
  });
}
