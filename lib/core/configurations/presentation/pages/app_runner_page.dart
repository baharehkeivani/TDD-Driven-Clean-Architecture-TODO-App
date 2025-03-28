import 'package:flutter/material.dart';
import 'package:todo_app/core/router/app_router.dart';

class AppRunnerPage extends StatelessWidget {
  const AppRunnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TODO App',
      routerConfig: AppRouter.instance.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
    );
  }
}
