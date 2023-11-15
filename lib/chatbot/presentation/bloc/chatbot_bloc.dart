import 'dart:async';

import 'package:chatbot/chatbot/chatbot.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc() : super(const ChatbotInitial()) {
    on<ChatbotMessageSent>(_onChatbotMessageSent);
  }

  FutureOr<void> _onChatbotMessageSent(
    ChatbotMessageSent event,
    Emitter<ChatbotState> emit,
  ) {
    emit(
      state.copyWith(
        messages: [...state.messages, ChatMessage(event.message)],
      ),
    );
  }
}
