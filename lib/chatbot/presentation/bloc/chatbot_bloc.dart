import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

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
  final AudioPlayer _audioPlayer = AudioPlayer();

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

    emit(
      state.copyWith(
        messages: [event.message, ...state.messages],
        status: ChatbotStatus.loading,
      ),
    );

    const String usernameAttachment = '. My username is $kHardcodedUsername';
    String message = event.message.message.text;
    if (event.attachUsername) message += usernameAttachment;

    final response = await _chatbotRepository.sendMessage(message);

    if (response?.audio != null) {
      _playAudio(response!.audio!);
    }

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
        status:
            response != null ? ChatbotStatus.success : ChatbotStatus.failure,
      ),
    );
  }

  _playAudio(Uint8List audioBytes) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentsDirectory.path}/audio_file.mp3';

    final file = File(filePath);
    await file.writeAsBytes(audioBytes);

    await _audioPlayer.setFilePath(filePath);
    await _audioPlayer.play();
  }
}
