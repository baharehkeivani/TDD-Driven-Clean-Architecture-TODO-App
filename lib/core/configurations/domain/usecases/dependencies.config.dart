// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:todo_app/features/todo/data/datasources/tasks_datesource.dart'
    as _i605;
import 'package:todo_app/features/todo/data/repositories/tasks_repository.dart'
    as _i873;
import 'package:todo_app/features/todo/data/repositories/tasks_repository_imp.dart'
    as _i961;
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart'
    as _i88;
import 'package:todo_app/features/todo/presentation/cubits/add_task_list_cubit.dart'
    as _i910;
import 'package:todo_app/features/todo/presentation/cubits/tasks_list_cubit.dart'
    as _i469;
import 'package:todo_app/features/todo/presentation/cubits/toggle_task_state_cubit.dart'
    as _i243;

const String _development = 'development';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i243.ToggleTaskStateCubit>(() => _i243.ToggleTaskStateCubit());
    gh.factory<_i469.TasksListCubit>(() => _i469.TasksListCubit());
    gh.factory<_i910.AddTaskCubit>(() => _i910.AddTaskCubit());
    gh.lazySingleton<_i605.TasksDatasource>(() => _i605.TasksDatasource());
    gh.lazySingleton<_i88.TasksService>(() => _i88.TasksService());
    gh.lazySingleton<_i873.TasksRepository>(
      () => _i961.TasksRepositoryImp(),
      registerFor: {_development},
    );
    return this;
  }
}
