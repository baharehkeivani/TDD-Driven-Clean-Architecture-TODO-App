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

import '../../../../features/task/data/repositories/tasks_repository.dart'
    as _i399;
import '../../../../features/task/data/repositories/tasks_repository_mock_imp.dart'
    as _i655;
import '../../../../features/task/domain/usecases/tasks_service.dart' as _i746;

const String _development = 'development';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i746.TasksService>(() => _i746.TasksService());
    gh.lazySingleton<_i399.TasksRepository>(
      () => _i655.TasksRepositoryMockImp(),
      registerFor: {_development},
    );
    return this;
  }
}
