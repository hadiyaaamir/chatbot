part of 'chatbot_repository.dart';

class ChatbotRepositoryImpl extends ChatbotRepository {
  ChatbotRepositoryImpl({required chatbotApi}) : _api = chatbotApi;

  final ChatbotApi _api;

  @override
  Future<void> initialise() async {
    await _api.initialise();
  }

  @override
  Future<MessagePayload?> sendMessage(String message) async {
    return await _api.sendMessage(message);
  }
}
