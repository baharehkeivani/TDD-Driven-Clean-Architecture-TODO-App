import 'package:mockito/annotations.dart';
import 'package:todo_app/features/todo/data/datasources/tasks_datesource.dart';
import 'package:todo_app/features/todo/domain/repositories/tasks_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

/// NOTE: In `TasksRepositoryImp`, a `TasksDatasource` is injected.
/// To properly test this repository, ensure that any injected dependencies,
/// such as `TasksDatasource`, are mocked to accurately simulate their behavior.
@GenerateNiceMocks([MockSpec<TasksDatasource>(), MockSpec<TasksRepository>(), MockSpec<TasksService>()])
void main() {}
