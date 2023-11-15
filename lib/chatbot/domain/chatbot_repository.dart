import 'package:chatbot/chatbot/chatbot.dart';

part 'chatbot_repository_impl.dart';

abstract class ChatbotRepository {
  Future<void> initialise();
  Future<String?> sendMessage(String message);
}
