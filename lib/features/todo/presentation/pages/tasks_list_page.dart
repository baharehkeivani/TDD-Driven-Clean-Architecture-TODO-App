import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/presentation/cubits/tasks_list_cubit.dart';
import 'package:todo_app/features/todo/presentation/widgets/add_task_dialog.dart';
import 'package:todo_app/features/todo/presentation/widgets/task_list_item_widget.dart';

import '../../domain/entities/task.dart';

class TasksListPage extends StatefulWidget {
  static String name = "todo";
  static String path = "/";

  const TasksListPage._();

  static wrapper() => BlocProvider(
    create: (context) => getIt<TasksListCubit>(),
    child: TasksListPage._(),
  );

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  late final ValueNotifier<DateTime> selectedDateNotifier;

  @override
  void initState() {
    selectedDateNotifier = ValueNotifier(DateTime.now());
    _initializePage();

    selectedDateNotifier.addListener(() => _initializePage());

    super.initState();
  }

  void _initializePage() =>
      context.read<TasksListCubit>().fetchTasks(selectedDateNotifier.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildDateSection(),
          Expanded(child: Center(child: _tasksSection())),
        ],
      ),
      floatingActionButton: _buildAddButton(),
    );
  }

  Widget _buildAddButton() => FilledButton(
    child: Icon(Icons.add),
    onPressed: () {
      showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) {
          return AddTaskDialog.wrapper(date: selectedDateNotifier.value);
        },
      );
    },
  );

  Widget _buildDateSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      alignment: Alignment.bottomCenter,
      color: Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: 0.2),
      child: SafeArea(
        child: CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(1800),
          lastDate: DateTime(3000),
          onDateChanged: (value) => selectedDateNotifier.value = value,
        ),
      ),
    );
  }

  Widget _tasksSection() {
    return ValueListenableBuilder(
      valueListenable: selectedDateNotifier,
      builder: (context, value, child) {
        return BlocBuilder<TasksListCubit, GetState>(
          builder: (context, state) {
            switch (state) {
              case InitialGetState():
              case LoadingGetState():
                return CircularProgressIndicator.adaptive(
                  constraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
                );
              case SuccessGetState():
                final List<Task> tasks = state.item;
                if (tasks.isEmpty) {
                  return _buildErrorWidget(
                    "There is nothing to show. Add a new task.",
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItemWidget.wrapper(task: tasks[index]);
                  },
                );
              case FailureGetState():
                return _buildErrorWidget(state.failure.getMessage(context));
            }
          },
        );
      },
    );
  }

  Widget _buildErrorWidget(String message) => Text(message);
}
