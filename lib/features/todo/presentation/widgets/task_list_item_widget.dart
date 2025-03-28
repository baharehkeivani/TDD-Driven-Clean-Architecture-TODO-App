import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/presentation/cubits/toggle_task_state_cubit.dart';

class TaskListItemWidget extends StatefulWidget {
  final Task task;

  const TaskListItemWidget._({required this.task});

  static wrapper({required Task task}) => BlocProvider(
    create: (context) => getIt<ToggleTaskStateCubit>(),
    child: TaskListItemWidget._(task: task),
  );

  @override
  State<TaskListItemWidget> createState() => _TaskListItemWidgetState();
}

class _TaskListItemWidgetState extends State<TaskListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_buildCheckBox(), Expanded(child: _buildTaskDetails())],
    );
  }

  Widget _buildCheckBox() => SizedBox.square(
    dimension: 20,
    child: BlocBuilder<ToggleTaskStateCubit, GetState>(
      builder: (context, state) {
        bool isDone = widget.task.isDone;
        switch (state) {
          case InitialGetState():
          case LoadingGetState():
            return CircularProgressIndicator.adaptive();
          case SuccessGetState():
            isDone = true;
          case FailureGetState():
            isDone = false;
        }
        return CheckboxListTile(
          value: isDone,
          onChanged: (value) {
            context.read<ToggleTaskStateCubit>().toggleTasks(widget.task.id);
          },
        );
      },
    ),
  );

  Widget _buildTaskDetails() => Text(widget.task.title); // TODO
}
