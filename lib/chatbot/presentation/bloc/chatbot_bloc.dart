import 'dart:async';

import 'package:chatbot/chatbot/chatbot.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc({required ChatbotRepository chatbotRepository})
      : _chatbotRepository = chatbotRepository,
        super(const ChatbotInitial()) {
    on<ChatbotSubscription>(_onChatbotSubscribed);
    on<ChatbotMessageSent>(_onChatbotMessageSent);
  }

  final ChatbotRepository _chatbotRepository;

  Future<void> _onChatbotSubscribed(
    ChatbotSubscription event,
    Emitter<ChatbotState> emit,
  ) async {
    await _chatbotRepository.initialise();
  }

  Future<void> _onChatbotMessageSent(
    ChatbotMessageSent event,
    Emitter<ChatbotState> emit,
  ) async {
    if (event.message.isEmpty) return;

    emit(
      state.copyWith(
        messages: [
          ChatMessage(message: MessagePayload(event.message)),
          ...state.messages
        ],
      ),
    );

    final response = await _chatbotRepository.sendMessage(event.message);

    emit(
      state.copyWith(
        messages: [
          ChatMessage(
            message: MessagePayload(
              response?.text ?? 'Unexpected error occurred',
              suggestions: response?.suggestions ?? [],
              options: response?.options,
              onlySuggestions: response?.onlySuggestions ?? false,
            ),
            sentMessage: false,
          ),
          ...state.messages,
        ],
      ),
    );
  }
}
