import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/extensions/date_time_extension.dart';
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
  late bool isDone;

  @override
  void initState() {
    isDone = widget.task.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: BlocBuilder<ToggleTaskStateCubit, GetState>(
        builder: (context, state) {
          isDone = state is SuccessGetState<bool> ? state.item : isDone;
          final style = TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
          );
          return CheckboxListTile.adaptive(
            title: Text(widget.task.title, style: style),
            subtitle: Text(widget.task.createdDate.getNiceTime(), style: style),
            value: isDone,
            enabled: state is! LoadingGetState,
            isError: state is FailureGetState,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              context.read<ToggleTaskStateCubit>().toggleTasks(widget.task);
            },
          );
        },
      ),
    );
  }
}
