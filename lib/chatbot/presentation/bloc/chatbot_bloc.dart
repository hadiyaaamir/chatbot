import 'dart:async';

import 'package:audio_manager/audio_manager.dart';

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
    on<ChatbotMessageRecordingStarted>(_onChatbotMessageRecordingStarted);
    on<ChatbotMessageRecordingStopped>(_onChatbotMessageRecordingStopped);
    on<ChatbotAudioMessagePlayed>(_onChatbotAudioMessagePlayed);
    on<ChatbotAudioMessageStopped>(_onChatbotAudioMessageStopped);
    on<ChatbotAllAudioMessagesStopped>(_onChatbotAllAudioMessagesStopped);

    _audioManager.audioPlayerCompleteStream.listen((isStopped) {
      if (isStopped) add(ChatbotAllAudioMessagesStopped());
    });
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
      message: ChatMessage(message: MessagePayload(text: 'hello')),
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
    final messagePayload = event.message.message;

    if (messagePayload.isEmpty) return;

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
      String message = messagePayload.text;
      if (event.attachUsername) message += usernameAttachment;

      final response = messagePayload.isTextMessage
          ? await _chatbotRepository.sendTextMessage(message)
          : await _chatbotRepository.sendAudioMessage(
              await _audioManager.audioFromPath(messagePayload.audio!.audio),
            );

      final outputAudio = _audioManager.stringToByte(response?.audio?.audio);
      if (outputAudio != null) _audioManager.playAudioFromBytes(outputAudio);

      emit(
        state.copyWith(
          messages: [
            ChatMessage(
              message: response ?? MessagePayload.fallback(),
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

  Future<void> _onChatbotMessageRecordingStarted(
    ChatbotMessageRecordingStarted event,
    Emitter<ChatbotState> emit,
  ) async {
    try {
      await _audioManager.startRecording();
      emit(state.copyWith(isRecordingMessage: _audioManager.isRecording));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          messages: [
            ChatMessage(
              message: MessagePayload(
                text: 'Error recording voice message. $e',
              ),
            ),
            ...state.messages,
          ],
          isRecordingMessage: _audioManager.isRecording,
        ),
      );
    }
  }

  Future<void> _onChatbotMessageRecordingStopped(
    ChatbotMessageRecordingStopped event,
    Emitter<ChatbotState> emit,
  ) async {
    try {
      final output = await _audioManager.stopRecording();
      emit(state.copyWith(isRecordingMessage: _audioManager.isRecording));

      if (output != null) {
        await _onChatbotMessageSent(
          ChatbotMessageSent(
            message: ChatMessage(
              message: MessagePayload(audio: Audio(audio: output)),
            ),
          ),
          emit,
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          messages: [
            ChatMessage(
              message: MessagePayload(
                text: 'Error recording voice message. $e',
              ),
            ),
            ...state.messages,
          ],
          isRecordingMessage: _audioManager.isRecording,
        ),
      );
    }
  }

  Future<void> _onChatbotAudioMessagePlayed(
    ChatbotAudioMessagePlayed event,
    Emitter<ChatbotState> emit,
  ) async {
    final message = event.message;
    if (message.audio == null) return;

    emit(state.setAudioPlayingStatus(targetMessage: message));
    await _audioManager.playAudioFromFile(message.audio!.audio);
  }

  Future<void> _onChatbotAudioMessageStopped(
    ChatbotAudioMessageStopped event,
    Emitter<ChatbotState> emit,
  ) async {
    final message = event.message;

    await _audioManager.pauseAudio();
    emit(state.setAudioStoppedStatus(targetMessage: message));
  }

  Future<void> _onChatbotAllAudioMessagesStopped(
    ChatbotAllAudioMessagesStopped event,
    Emitter<ChatbotState> emit,
  ) async {
    emit(state.setAllAudiosStoppedStatus());
  }
}
