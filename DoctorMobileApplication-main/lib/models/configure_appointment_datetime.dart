import 'package:flutter/material.dart';

class AppointmentDateTime {
  final String day;
  final List<TimeRange> timeRanges;

  AppointmentDateTime({
    required this.day,
    required this.timeRanges,
  });
}

class TimeRange {
  TimeOfDay startTime;
  TimeOfDay endTime;

  TimeRange(this.startTime, this.endTime);
}
