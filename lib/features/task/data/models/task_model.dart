import 'package:flutter/material.dart';
import 'package:todo_app/features/task/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.dateTimeRange,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'startDateTime': dateTimeRange.start.toIso8601String(),
    'endDateTime': dateTimeRange.end.toIso8601String(),
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final startDateTime = DateTime.parse(json['startDateTime']);
    final endDateTime = DateTime.parse(json['endDateTime']);
    return TaskModel(
      id: json['json'],
      title: json['title'],
      dateTimeRange: DateTimeRange(start: startDateTime, end: endDateTime),
    );
  }

  Task toSuper() => Task(id: id, title: title, dateTimeRange: dateTimeRange);
}
