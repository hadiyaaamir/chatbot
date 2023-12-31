part of 'chatbot_bloc.dart';

enum ChatbotStatus { initial, loading, success, failure }

class ChatbotState extends Equatable {
  const ChatbotState({
    required this.messages,
    required this.status,
    required this.isRecordingMessage,
    this.isMuted = false,
  });

  final List<ChatMessage> messages;
  final ChatbotStatus status;

  final bool isRecordingMessage;
  final bool isMuted;

  ChatbotState setAudioPlayingStatus({required MessagePayload targetMessage}) {
    final List<ChatMessage> updatedMessages = messages.map((message) {
      return message.message == targetMessage
          ? message.playAudio()
          : message.message.audio != null
              ? message.stopAudio()
              : message;
    }).toList();

    return copyWith(messages: updatedMessages);
  }

  ChatbotState setAudioStoppedStatus({required MessagePayload targetMessage}) {
    final List<ChatMessage> updatedMessages = messages.map((message) {
      return message.message == targetMessage && message.message.audio != null
          ? message.stopAudio()
          : message;
    }).toList();

    return copyWith(messages: updatedMessages);
  }

  ChatbotState setAllAudiosStoppedStatus() {
    final List<ChatMessage> updatedMessages = messages.map((message) {
      return message.message.audio != null ? message.stopAudio() : message;
    }).toList();

    return copyWith(messages: updatedMessages);
  }

  ChatbotState selectEventSlot({
    required Event event,
    required ChatEventSlot eventSlot,
  }) {
    final latestMessage = messages.first;
    final updatedMessages = [
      latestMessage.copyWith(
        message: latestMessage.message.copyWith(
          options:
              (latestMessage.message.options as List<dynamic>).map((option) {
            return (option as Event) == event
                ? event.selectSlot(eventSlot: eventSlot)
                : option;
          }).toList(),
        ),
      ),
      ...messages..removeAt(0),
    ];
    return copyWith(messages: updatedMessages);
  }

  ChatbotState selectEventTimeSlot({
    required Event event,
    required ChatEventSlot eventSlot,
    required ChatEventTimeSlot timeSlot,
  }) {
    final latestMessage = messages.first;
    final updatedMessages = [
      latestMessage.copyWith(
        message: latestMessage.message.copyWith(
          options: (latestMessage.message.options as List<Event>).map((option) {
            return option == event
                ? event.selectTimeSlot(eventSlot: eventSlot, timeSlot: timeSlot)
                : option;
          }).toList(),
        ),
      ),
      ...messages..removeAt(0),
    ];
    return copyWith(messages: updatedMessages);
  }

  ChatbotState toggleMute() {
    return copyWith(isMuted: !isMuted);
  }

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    ChatbotStatus? status,
    bool? isRecordingMessage,
    bool? isMuted,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isRecordingMessage: isRecordingMessage ?? this.isRecordingMessage,
      isMuted: isMuted ?? this.isMuted,
    );
  }

  @override
  List<Object> get props => [messages, status, isRecordingMessage, isMuted];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial()
      : super(
          messages: const [],
          status: ChatbotStatus.initial,
          isRecordingMessage: false,
        );
}
