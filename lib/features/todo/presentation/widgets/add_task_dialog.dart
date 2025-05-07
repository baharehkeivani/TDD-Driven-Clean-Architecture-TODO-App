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
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddTaskDialog._({required this.date, this.onAddedTask});

  static wrapper({required DateTime date, void Function(Task? task)? onAddedTask}) =>
      BlocProvider(create: (context) => getIt<AddTaskCubit>(), child: AddTaskDialog._(date: date, onAddedTask: onAddedTask));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocListener<AddTaskCubit, GetState>(
        listener: (context, state) {
          if (state is SuccessGetState) {
            onAddedTask?.call(state.item);
            context.pop();
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(maxWidth: 300),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).cardColor),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter task\'s title',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: validator,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: context.pop,
                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _onSubmit(context),
                        child: Text("Add Task", style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<AddTaskCubit>().addTask(Task.fromDate(title: _textEditingController.text, createdDate: date));
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) return "You must write a title for the task!";
    return null;
  }
}
