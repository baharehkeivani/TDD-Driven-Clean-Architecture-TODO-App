import 'package:flutter/material.dart';
import 'package:todo_app/features/home/presentation/widgets/date_picker_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Center(child: DatePickerWidget(onChange: (date) {}))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',

        child: const Icon(Icons.add),
      ),
    );
  }
}
