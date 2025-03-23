import 'package:flutter/material.dart';
import 'package:local_hero/local_hero.dart';
import 'package:todo_app/core/extentions/date_time_extention.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime date) onChange;

  const DatePickerWidget({super.key, required this.onChange, this.initialDate});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;

  final _kDayContainerCount = 5;

  @override
  void initState() {
    selectedDate = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _buildDays();

  Widget _buildDays() => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onHorizontalDragUpdate: (details) {
      final dayOffset = details.globalPosition.dx.floor()%5;
      DateTime date = _getDateWithDayOffset(dayOffset);
      setState(() => selectedDate = date);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(_kDayContainerCount, (index) {
        final dayOffset = index - (_kDayContainerCount / 2).floor();
        DateTime date = _getDateWithDayOffset(dayOffset);
        return _buildDayContainer(date, dayOffset);
      }),
    ),
  );

  Widget _buildDayContainer(DateTime date, int dayOffset) {
    final isSelected = (dayOffset == 0);
    final color =
        isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).disabledColor.withValues(alpha: 0.1);
    final verticalPadding = 28.0 - (dayOffset.abs() * 4);
    final horizontalPadding = 16.0 - (dayOffset.abs() * 4);
    final fontSize = isSelected ? 24.0 : null;
    final textColor =
        isSelected
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).disabledColor;
    final borderRadius = BorderRadius.circular(100);

    return InkWell(
      borderRadius: borderRadius,
      onTap: () {
        if (isSelected) return;
        setState(() => selectedDate = date);
      },
      child: LocalHero(
        tag: dayOffset,
        child: AnimatedContainer(
          curve: Curves.ease,
          duration: Duration(microseconds: 3000),
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(color: color, borderRadius: borderRadius),
          child: SizedBox(
            width: 30,
            child: Column(
              spacing: 8,
              children: [
                Text(
                  date.day.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                ),
                Text(
                  date.weekDayString.substring(0, 3),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime _getDateWithDayOffset(int days) {
    if (days > 0) return selectedDate.add(Duration(days: days));
    if (days < 0) return selectedDate.subtract(Duration(days: days.abs()));
    return selectedDate;
  }
}
