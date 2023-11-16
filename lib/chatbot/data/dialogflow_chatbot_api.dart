part of 'chatbot_api.dart';

class DialogflowChatbotApi extends ChatbotApi {
  late DialogFlowtter dialogFlowtter;

  @override
  Future<void> initialise() async {
    String sessionId = DateTime.now().toIso8601String();
    dialogFlowtter = await DialogFlowtter.fromFile(sessionId: sessionId);
  }

  @override
  Future<String?> sendMessage(String message) async {
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: message)),
    );
    return response.text;
  }
}
