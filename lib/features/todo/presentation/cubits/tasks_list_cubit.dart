import 'package:injectable/injectable.dart';
import 'package:todo_app/core/state_manager/base_cubit.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

@Injectable()
class TasksListCubit extends BaseCubit<GetState> {
  final TasksService _service;

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TasksListCubit(this._service) : super(initialState: InitialGetState());

  Future<void> fetchTasks(DateTime date) async {
    emit(LoadingGetState());
    final result = await _service.getTasksByDate(date);
    result.fold((failure) => emit(FailureGetState(failure)), (tasks) {
      _tasks = tasks;
      emit(SuccessGetState(tasks));
    });
  }

  void addTask(Task task) {
    _tasks.add(task);
    emit(SuccessGetState(List.of(_tasks)));
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    emit(SuccessGetState(_tasks));
  }
}
