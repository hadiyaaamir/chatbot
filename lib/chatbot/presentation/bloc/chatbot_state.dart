part of 'chatbot_bloc.dart';

enum ChatbotStatus { initial, loading, success, failure }

class ChatbotState extends Equatable {
  const ChatbotState({
    required this.messages,
    required this.status,
    required this.isRecordingMessage,
  });

  final List<ChatMessage> messages;
  final ChatbotStatus status;

  final bool isRecordingMessage;

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

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    ChatbotStatus? status,
    bool? isRecordingMessage,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isRecordingMessage: isRecordingMessage ?? this.isRecordingMessage,
    );
  }

  @override
  List<Object> get props => [messages, status, isRecordingMessage];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial()
      : super(
          messages: const [],
          status: ChatbotStatus.initial,
          isRecordingMessage: false,
        );
}
