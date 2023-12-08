import 'package:chatbot/events/events.dart';
import 'package:equatable/equatable.dart';
import 'package:chatbot/utils/models/models.dart';
import 'package:flutter/foundation.dart';

part 'chat_event_date_slot.dart';
part 'chat_event_time_slot.dart';

@immutable
class ChatEventSlot extends Equatable {
  const ChatEventSlot({
    required this.date,
    required this.timeSlots,
  });

  final ChatEventDateSlot date;
  final List<ChatEventTimeSlot> timeSlots;

  factory ChatEventSlot.fromEventSlot(EventSlot eventSlot) {
    return ChatEventSlot(
      date: ChatEventDateSlot(dateSlot: eventSlot.date),
      timeSlots: eventSlot.slots
          .map((timeSlot) => ChatEventTimeSlot(timeSlot: timeSlot))
          .toList(),
    );
  }

  ChatEventSlot setDateSelected(bool selected) {
    return copyWith(date: date.setDateSelected(selected))
        .setTimeSelected(timeSlots.first);
  }

  ChatEventSlot setTimeSelected(ChatEventTimeSlot timeSlot) {
    final List<ChatEventTimeSlot> updatedTimeSlots = timeSlots.map((slot) {
      return slot.setTimeSelected(slot == timeSlot);
    }).toList();
    return copyWith(timeSlots: updatedTimeSlots);
  }

  ChatEventTimeSlot? get selectedTimeSlot {
    final selectedTimes = timeSlots.where((element) => element.isSelected);
    if (selectedTimes.isEmpty) return null;
    return selectedTimes.first;
  }

  ChatEventSlot copyWith({
    ChatEventDateSlot? date,
    List<ChatEventTimeSlot>? timeSlots,
  }) {
    return ChatEventSlot(
      date: date ?? this.date,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  @override
  List<Object> get props => [date, timeSlots];
}
