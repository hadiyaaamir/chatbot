part of 'models.dart';

class EventSlot extends Equatable {
  const EventSlot({required this.date, required this.slots});

  final DateTime date;
  final List<TimeSlot> slots;

  factory EventSlot.fromJson(Map<String, dynamic> json) {
    return EventSlot(
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000)
          : DateTime.now(),
      slots: json['slots'] != null
          ? List<TimeSlot>.from(
              (json['slots'] as List<dynamic>).map(
                (slotJson) => TimeSlot.fromJson(slotJson),
              ),
            )
          : [],
    );
  }

  @override
  List<Object> get props => [date, slots];
}
