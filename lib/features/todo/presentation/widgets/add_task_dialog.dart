import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/presentation/cubits/add_task_cubit.dart';

import '../../../../core/configurations/domain/usecases/dependencies.dart';

class AddTaskDialog extends StatelessWidget {
  final DateTime date;
  final void Function(Task? task)? onAddedTask;
  final TextEditingController textEditingController = TextEditingController();

  AddTaskDialog._({required this.date, this.onAddedTask});

  static wrapper({
    required DateTime date,
    void Function(Task? task)? onAddedTask,
  }) => BlocProvider(
    create: (context) => getIt<AddTaskCubit>(),
    child: AddTaskDialog._(date: date, onAddedTask: onAddedTask),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskCubit, GetState>(
      listener: (context, state) {
        if (state is SuccessGetState) {
          onAddedTask?.call(state.item);
          context.pop();
        }
      },
      child: AlertDialog.adaptive(titlePadding: EdgeInsets.zero,
        content: Material(
          color: Colors.transparent,
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter task\'s title',
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: context.pop,
            child: Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => _onSubmit(context),
            child: Text("Add Task"),
          ),
        ],
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    context.read<AddTaskCubit>().addTask(
      Task.fromDate(title: textEditingController.text, createdDate: date),
    );
  }
}
