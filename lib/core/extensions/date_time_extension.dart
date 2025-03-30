import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  Map<int, String> get weekdays => {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday",
  };

  Map<int, String> get months => {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  String get weekdayName => weekdays[weekday] ?? "";

  String get monthName => months[month] ?? "";

  String getNiceDate(
    BuildContext context, {
    bool includeWeekName = true,
    bool includeDay = true,
    bool includeMonthName = true,
    bool includeYear = true,
  }) {
    List<String> parts = [];

    if (includeWeekName) parts.add(weekdayName);
    if (includeDay) parts.add(day.toString());
    if (includeMonthName) parts.add(monthName);
    if (includeYear) parts.add(year.toString());

    return parts.join(' ');
  }

  String getNiceTime() => DateFormat('hh:mm a').format(this);

  bool isAtSameDateAs(DateTime other) =>
      other.year == year && other.month == month && other.day == day;
}
