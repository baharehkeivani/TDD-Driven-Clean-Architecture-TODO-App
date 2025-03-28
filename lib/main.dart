import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/core/configurations/presentation/pages/app_runner_page.dart';

import 'core/configurations/domain/usecases/dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  configureDependencies();

  runApp(const AppRunnerPage());
}
