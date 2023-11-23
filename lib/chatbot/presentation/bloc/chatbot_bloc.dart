import 'dart:async';

import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/chatbot/utils/constants.dart';
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
    if (event.message.message.text.isEmpty) return;

    emit(state.copyWith(messages: [event.message, ...state.messages]));

    const String usernameAttachment = '. My username is $kHardcodedUsername';
    String message = event.message.message.text;
    if (event.attachUsername) message += usernameAttachment;

    print('sending message: $message');

    final response = await _chatbotRepository.sendMessage(message);

    print('sending message: $message');

    emit(
      state.copyWith(
        messages: [
          ChatMessage(
            message:
                response ?? const MessagePayload('Unexpected error occured'),
            sentMessage: false,
          ),
          ...state.messages,
        ],
      ),
    );
  }
}
