import 'package:dialog_flowtter/dialog_flowtter.dart';

part 'dialogflow_chatbot_api.dart';

abstract class ChatbotApi {
  Future<void> initialise();
  Future<String?> sendMessage(String message);
}
