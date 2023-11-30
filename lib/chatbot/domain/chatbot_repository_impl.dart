part of 'chatbot_repository.dart';

class ChatbotRepositoryImpl extends ChatbotRepository {
  ChatbotRepositoryImpl({required chatbotApi}) : _api = chatbotApi;

  final ChatbotApi _api;

  @override
  Future<void> initialise() async {
    await _api.initialise();
  }

  @override
  Future<MessagePayload?> sendTextMessage(String message) async {
    return await _api.sendTextMessage(message);
  }

  @override
  Future<MessagePayload?> sendAudioMessage(String audioInput) async {
    return await _api.sendAudioMessage(audioInput);
  }
}
