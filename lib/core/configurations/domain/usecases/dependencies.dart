import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import '../entities/environment.dart';
import 'dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  _configureHiveAdapters();

  getIt.init(environment: environment);
}

void _configureHiveAdapters() {
  Hive.registerAdapter(TaskAdapter());
}
