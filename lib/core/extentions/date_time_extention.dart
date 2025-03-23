extension DateTimeExtention on DateTime {
  List<String> get _weekDaysString => [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Sunday",
    "Saturday",
  ];

  String get weekDayString => _weekDaysString[weekday - 1];
}
