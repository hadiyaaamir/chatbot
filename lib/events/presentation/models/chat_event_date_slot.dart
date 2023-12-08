part of 'chat_event_slot.dart';

class ChatEventDateSlot extends Equatable {
  const ChatEventDateSlot({
    required this.dateSlot,
    this.isSelected = false,
  });

  final DateTime dateSlot;
  final bool isSelected;

  ChatEventDateSlot setDateSelected(bool selected) {
    return copyWith(isSelected: selected);
  }

  ChatEventDateSlot copyWith({
    DateTime? dateSlot,
    List<ChatEventTimeSlot>? timeSlots,
    bool? isSelected,
  }) {
    return ChatEventDateSlot(
      dateSlot: dateSlot ?? this.dateSlot,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [dateSlot, isSelected];
}
