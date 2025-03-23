import 'package:flutter/material.dart';

import '../../../../features/home/presentation/pages/home_page.dart';

class AppRunnerPage extends StatelessWidget {
  const AppRunnerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const HomePage(),
    );
  }
}