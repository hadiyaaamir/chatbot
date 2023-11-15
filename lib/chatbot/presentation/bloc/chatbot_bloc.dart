import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/chatbot/chatbot.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc() : super(const ChatbotInitial()) {
    on<ChatbotCustomEvent>(_onChatbotEvent);
  }

  FutureOr<void> _onChatbotEvent(
    ChatbotCustomEvent event,
    Emitter<ChatbotState> emit,
  ) {
    // TODO: Add Logic
  }
}
