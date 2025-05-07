import 'package:injectable/injectable.dart';
import 'package:todo_app/core/state_manager/base_cubit.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

import '../../domain/entities/task.dart';

@Injectable()
class ToggleTaskStateCubit extends BaseCubit<GetState> {
  final TasksService _service;

  ToggleTaskStateCubit(this._service) : super(initialState: InitialGetState());

  Future<void> toggleTasks(Task task) async {
    emit(LoadingGetState());
    final result = await _service.toggleTaskState(task);
    result.fold((failure) => emit(FailureGetState(failure)), (isDone) => emit(SuccessGetState<bool>(isDone)));
  }
}
