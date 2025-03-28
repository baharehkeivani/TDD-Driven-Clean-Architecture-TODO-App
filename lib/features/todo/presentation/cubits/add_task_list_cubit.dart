import 'package:injectable/injectable.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/state_manager/base_cubit.dart';
import 'package:todo_app/core/state_manager/entities/set_state.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

@Injectable()
class AddTaskCubit extends BaseCubit<SetState> {
  final TasksService _service;

  AddTaskCubit()
    : _service = getIt<TasksService>(),
      super(initialState: InitialSetState());

  Future<void> fetchTasks(Task task) async {
    emit(LoadingSetState());
    final result = await _service.addTask(task);
    result.fold(
      (failure) => emit(FailureSetState(failure)),
      (_) => emit(SuccessSetState()),
    );
  }
}
