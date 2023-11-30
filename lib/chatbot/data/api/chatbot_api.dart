import 'package:chatbot/chatbot/chatbot.dart';

export 'dialogflow_google_api.dart';
export 'dialog_flowtter_chatbot_api.dart';

abstract class ChatbotApi {
  Future<void> initialise();
  Future<MessagePayload?> sendTextMessage(String message);
  Future<MessagePayload?> sendAudioMessage(String audioInput);
}
