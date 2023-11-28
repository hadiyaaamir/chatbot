import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/chatbot/data/models/models.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

part 'dialogflow_chatbot_api.dart';

abstract class ChatbotApi {
  Future<void> initialise();
  Future<MessagePayload?> sendMessage(String message);
}
