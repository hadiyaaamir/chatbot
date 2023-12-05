import 'package:chatbot/chatbot/chatbot.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class DialogFlowtterChatbotApi extends ChatbotApi {
  late DialogFlowtter dialogFlowtter;

  @override
  Future<void> initialise() async {
    String sessionId = DateTime.now().toIso8601String();
    dialogFlowtter = await DialogFlowtter.fromFile(sessionId: sessionId);
  }

  @override
  Future<MessagePayload?> sendTextMessage(String message) async {
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: message)),
    );

    if (response.message == null) return null;

    final outputAudio = response.outputAudio != null
        ? Audio(audio: response.outputAudio!)
        : null;

    return response.message!.payload == null
        ? MessagePayload(text: response.text ?? MessagePayload.error().text)
            .copyWith(audio: outputAudio)
        : MessagePayload.fromJson(response.message!.payload!)
            .copyWith(audio: outputAudio);
  }

  @override
  Future<MessagePayload?> sendAudioMessage(String audioInput) {
    throw UnimplementedError();
  }
}
