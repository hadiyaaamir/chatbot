import 'dart:convert';

import 'package:chatbot/audio/audio.dart';
import 'package:chatbot/chatbot/chatbot.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/dialogflow/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

class DialogflowGoogleApi extends ChatbotApi {
  late DialogflowApi _dialogflowApi;
  late ProjectsAgentSessionsResource _resource;

  late String _sessionId;

  Future<Map<String, dynamic>> _loadCredentials() async {
    final String jsonString = await rootBundle.loadString(
      'assets/dialog_flow_auth.json',
    );
    return json.decode(jsonString);
  }

  @override
  Future<void> initialise() async {
    _sessionId = 'projects/flutterbot-griv/agent/sessions/FlutterBot';

    final credentials = await _loadCredentials();

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(credentials),
      [DialogflowApi.cloudPlatformScope],
    );
    _dialogflowApi = DialogflowApi(client);
    _resource = _dialogflowApi.projects.agent.sessions;
  }

  @override
  Future<MessagePayload?> sendMessage(String message,
      {String? inputAudio}) async {
    try {
      final textInput = GoogleCloudDialogflowV2TextInput(
        text: message,
        languageCode: "en",
      );
      final queryInput = GoogleCloudDialogflowV2QueryInput(text: textInput);

      final response = await _resource.detectIntent(
        GoogleCloudDialogflowV2DetectIntentRequest(
          queryInput: queryInput,
          inputAudio: inputAudio,
        ),
        _sessionId,
      );

      if (response.queryResult == null ||
          response.queryResult?.fulfillmentMessages == null) return null;
      if (response.queryResult!.fulfillmentMessages!.isEmpty) return null;

      final fulfillmentMessages = response.queryResult!.fulfillmentMessages!;
      final fulfillmentText = response.queryResult?.fulfillmentText;

      final audioOutputBytes = AudioManager.stringToByte(response.outputAudio);

      for (final message in fulfillmentMessages) {
        if (message.payload != null) {
          return MessagePayload.fromJson(
                  message.payload as Map<String, dynamic>)
              .copyWith(audio: audioOutputBytes);
        }
      }

      return MessagePayload(fulfillmentText ?? 'Unexpected Error Occurred')
          .copyWith(audio: audioOutputBytes);
    } on Exception catch (e) {
      return MessagePayload('Error occured: ${e.toString()}');
    }
  }
}
