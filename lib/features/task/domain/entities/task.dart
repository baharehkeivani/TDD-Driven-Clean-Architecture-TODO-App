import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final DateTimeRange dateTimeRange;

  const Task({
    required this.id,
    required this.title,
    required this.dateTimeRange,
  });

  @override
  List<Object?> get props => [id];
}
