import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TimeSlot extends Equatable {
  const TimeSlot({required this.startingTime, required this.endingTime});

  final TimeOfDay startingTime;
  final TimeOfDay endingTime;

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startingTime: _timeFromDate(json['startingTime'] as String?),
      endingTime: _timeFromDate(json['endingTime'] as String?),
    );
  }

  static TimeOfDay _timeFromDate(String? timeString) {
    return timeString == null
        ? const TimeOfDay(hour: 0, minute: 0)
        : TimeOfDay.fromDateTime(DateTime.parse(timeString).toLocal());
  }

  @override
  String toString() {
    final String start = _formatTimeOfDay(startingTime).toLowerCase();
    final String end = _formatTimeOfDay(endingTime).toLowerCase();
    return '$start - $end';
  }

  String get startingTimeString => _formatTimeOfDay(startingTime);
  String get endingTimeString => _formatTimeOfDay(endingTime);

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final String period = timeOfDay.period == DayPeriod.am ? 'am' : 'pm';
    final int hour = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
    final String minute = '${timeOfDay.minute}'.padLeft(2, '0');

    return '$hour:$minute$period';
  }

  @override
  List<Object> get props => [startingTime, endingTime];
}
