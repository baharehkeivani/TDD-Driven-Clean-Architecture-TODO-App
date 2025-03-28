import 'package:injectable/injectable.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/state_manager/base_cubit.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

@Injectable()
class ToggleTaskStateCubit extends BaseCubit<GetState> {
  final TasksService _service;

  ToggleTaskStateCubit()
    : _service = getIt<TasksService>(),
      super(initialState: InitialGetState());

  Future<void> toggleTasks(String id) async {
    emit(LoadingGetState());
    final result = await _service.toggleTaskState(id);
    result.fold(
      (failure) => emit(FailureGetState(failure)),
      (isDone) => emit(SuccessGetState<bool>(isDone)),
    );
  }
}
