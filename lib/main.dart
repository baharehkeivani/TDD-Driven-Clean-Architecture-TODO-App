import 'package:flutter/material.dart';
import 'package:todo_app/core/configurations/presentation/pages/app_runner_page.dart';

import 'core/configurations/domain/usecases/dependencies.dart';

void main() {
  configureDependencies();
  runApp(const AppRunnerPage());
}
