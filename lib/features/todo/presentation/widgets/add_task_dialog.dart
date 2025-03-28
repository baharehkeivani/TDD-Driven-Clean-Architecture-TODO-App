import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/cubits/add_task_list_cubit.dart';

import '../../../../core/configurations/domain/usecases/dependencies.dart';

class AddTaskDialog extends StatelessWidget {
  final DateTime date;

  const AddTaskDialog._({required this.date});

  static wrapper({required DateTime date}) => BlocProvider(
    create: (context) => getIt<AddTaskCubit>(),
    child: AddTaskDialog._(date: date),
  );

  @override
  Widget build(BuildContext context) {
    return TextField();
  }
}
