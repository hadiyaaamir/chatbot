part of 'models.dart';

class TicketSlot extends Equatable {
  const TicketSlot({required this.date, required this.timeSlot});

  final DateTime date;
  final TimeSlot timeSlot;

  factory TicketSlot.fromJson(Map<String, dynamic> json) {
    return TicketSlot(
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now(),
      timeSlot: TimeSlot.fromJson(
        json['timeSlot'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  bool get isUpcoming {
    final today = DateTime.now();
    final todaysDateOnly = DateTime(today.year, today.month, today.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly.isAfter(todaysDateOnly)) return true;

    final currentTime = TimeOfDay.now();
    if (timeSlot.startingTime.hour > currentTime.hour) return true;
    if (timeSlot.startingTime.minute > currentTime.minute) return true;

    return false;
  }

  @override
  List<Object> get props => [date, timeSlot];
}
