import 'package:chatbot/chatbot/chatbot.dart';

export 'dialogflow_api.dart';
export 'dialogflow_chatbot_api.dart';

abstract class ChatbotApi {
  Future<void> initialise();
  Future<MessagePayload?> sendMessage(String message);
}
