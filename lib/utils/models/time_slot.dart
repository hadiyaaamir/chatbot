import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TimeSlot extends Equatable {
  const TimeSlot({required this.startingTime, required this.endingTime});

  final TimeOfDay startingTime;
  final TimeOfDay endingTime;

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startingTime: _parseTimeOfDay(json['startingTime'] as String? ?? "00:00"),
      endingTime: _parseTimeOfDay(json['endingTime'] as String? ?? "00:00"),
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final List<String> components = timeString.split(':');
    final int hour = int.parse(components[0]);
    final int minute = int.parse(components[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String toString() {
    final String start = _formatTimeOfDay(startingTime).toLowerCase();
    final String end = _formatTimeOfDay(endingTime).toLowerCase();
    return '$start - $end';
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final String period = timeOfDay.period == DayPeriod.am ? 'am' : 'pm';
    final int hour = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
    final String minute = '${timeOfDay.minute}'.padLeft(2, '0');

    return '$hour:$minute$period';
  }

  @override
  List<Object> get props => [startingTime, endingTime];
}
