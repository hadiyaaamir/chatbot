import 'dart:async';

import 'package:chatbot/audio/audio.dart';
import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc({
    required ChatbotRepository chatbotRepository,
    required AudioManager audioManager,
  })  : _chatbotRepository = chatbotRepository,
        _audioManager = audioManager,
        super(const ChatbotInitial()) {
    on<ChatbotSubscription>(_onChatbotSubscribed);
    on<ChatbotMessageSent>(_onChatbotMessageSent);
  }

  final ChatbotRepository _chatbotRepository;
  final AudioManager _audioManager;

  Future<void> _onChatbotSubscribed(
    ChatbotSubscription event,
    Emitter<ChatbotState> emit,
  ) async {
    await _chatbotRepository.initialise();
    await _sendHelloMessage(emit);
  }

  Future<void> _sendHelloMessage(Emitter<ChatbotState> emit) async {
    const helloMessage = ChatbotMessageSent(
      message: ChatMessage(message: MessagePayload('hello')),
    );

    await _onChatbotMessageSent(
      helloMessage,
      emit,
      showSentMessage: false,
    );
  }

  Future<void> _onChatbotMessageSent(
    ChatbotMessageSent event,
    Emitter<ChatbotState> emit, {
    bool showSentMessage = true,
  }) async {
    if (event.message.message.text.isEmpty) return;

    try {
      emit(
        state.copyWith(
          messages: showSentMessage
              ? [event.message, ...state.messages]
              : state.messages,
          status: ChatbotStatus.loading,
        ),
      );

      const String usernameAttachment = '. My username is $kHardcodedUsername';
      String message = event.message.message.text;
      if (event.attachUsername) message += usernameAttachment;

      final response = await _chatbotRepository.sendTextMessage(message);

      if (response?.audio != null) _audioManager.playAudio(response!.audio!);

      emit(
        state.copyWith(
          messages: [
            ChatMessage(
              message: response ?? MessagePayload.error(),
              sentMessage: false,
            ),
            ...state.messages,
          ],
          status:
              response != null ? ChatbotStatus.success : ChatbotStatus.failure,
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          messages: [
            ChatMessage(message: MessagePayload.error(), sentMessage: false),
            ...state.messages,
          ],
          status: ChatbotStatus.failure,
        ),
      );
    }
  }
}
