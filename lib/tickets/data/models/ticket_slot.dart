part of 'models.dart';

class TicketSlot extends Equatable {
  const TicketSlot({required this.date, required this.timeSlot});

  final DateTime date;
  final TimeSlot timeSlot;

  factory TicketSlot.fromJson(Map<String, dynamic> json) {
    return TicketSlot(
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000)
          : DateTime.now(),
      timeSlot: TimeSlot.fromJson(
        json['timeSlot'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  @override
  List<Object> get props => [date, timeSlot];
}