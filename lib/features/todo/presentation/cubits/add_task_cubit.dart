import 'package:injectable/injectable.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/state_manager/base_cubit.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

import '../../../../core/state_manager/entities/get_state.dart';

@Injectable()
class AddTaskCubit extends BaseCubit<GetState> {
  final TasksService _service;

  AddTaskCubit()
    : _service = getIt<TasksService>(),
      super(initialState: InitialGetState());

  Future<void> addTask(Task task) async {
    emit(LoadingGetState());
    final result = await _service.addTask(task);
    result.fold(
      (failure) => emit(FailureGetState(failure)),
      (task) => emit(SuccessGetState(task)),
    );
  }
}
