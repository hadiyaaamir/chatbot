part of 'chat_event_slot.dart';

class ChatEventTimeSlot extends Equatable {
  const ChatEventTimeSlot({required this.timeSlot, this.isSelected = false});

  final TimeSlot timeSlot;
  final bool isSelected;

  ChatEventTimeSlot setTimeSelected(bool selected) {
    return copyWith(isSelected: selected);
  }

  ChatEventTimeSlot copyWith({TimeSlot? timeSlot, bool? isSelected}) {
    return ChatEventTimeSlot(
      timeSlot: timeSlot ?? this.timeSlot,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [timeSlot, isSelected];
}
