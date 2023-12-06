part of 'chatbot_bloc.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object> get props => [];
}

class ChatbotSubscription extends ChatbotEvent {}

class ChatbotMessageSent extends ChatbotEvent {
  const ChatbotMessageSent({
    required this.message,
    this.attachUsername = false,
  });
  final ChatMessage message;
  final bool attachUsername;

  @override
  List<Object> get props => [message, attachUsername];
}

class ChatbotMessageRecordingStarted extends ChatbotEvent {}

class ChatbotMessageRecordingStopped extends ChatbotEvent {}

class ChatbotAudioMessagePlayed extends ChatbotEvent {
  const ChatbotAudioMessagePlayed({required this.message});
  final MessagePayload message;

  @override
  List<Object> get props => [message];
}

class ChatbotAudioMessageStopped extends ChatbotEvent {
  const ChatbotAudioMessageStopped({required this.message});
  final MessagePayload message;

  @override
  List<Object> get props => [message];
}

class ChatbotAllAudioMessagesStopped extends ChatbotEvent {}

class ChatbotMessageEventSlotSelected extends ChatbotEvent {
  const ChatbotMessageEventSlotSelected({
    required this.event,
    required this.selectedEvent,
  });

  final Event event;
  final ChatEventSlot selectedEvent;

  @override
  List<Object> get props => [event, selectedEvent];
}

class ChatbotMessageEventTimeSlotSelected extends ChatbotEvent {
  const ChatbotMessageEventTimeSlotSelected({
    required this.event,
    required this.selectedEvent,
    required this.selectedTime,
  });

  final Event event;
  final ChatEventSlot selectedEvent;
  final ChatEventTimeSlot selectedTime;

  @override
  List<Object> get props => [event, selectedEvent, selectedTime];
}
