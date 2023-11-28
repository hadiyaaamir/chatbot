part of 'chatbot_api.dart';

class DialogflowESChatbotApi extends ChatbotApi {
  late DialogFlowtter dialogFlowtter;

  @override
  Future<void> initialise() async {
    String sessionId = DateTime.now().toIso8601String();
    dialogFlowtter = await DialogFlowtter.fromFile(sessionId: sessionId);
  }

  @override
  Future<MessagePayload?> sendMessage(String message) async {
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: message)),
    );

    if (response.message == null) return null;

    return response.message!.payload == null
        ? MessagePayload(response.text ?? 'Unexpected Error Occurred')
        : MessagePayload.fromJson(response.message!.payload!)
            .copyWith(audio: response.outputAudioBytes);
  }
}
