import 'dart:convert';

import 'package:chatbot/chatbot/chatbot.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/dialogflow/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

class DialogflowGoogleApi extends ChatbotApi {
  late DialogflowApi _dialogflowApi;
  late ProjectsAgentSessionsResource _resource;

  late String _sessionId;

  final String botId = 'ticketbookingbot-kjmn';
  final String botName = 'TicketBookingBot';

  Future<Map<String, dynamic>> _loadCredentials() async {
    final String jsonString = await rootBundle.loadString(
      'assets/dialog_flow_auth.json',
    );
    return json.decode(jsonString);
  }

  @override
  Future<void> initialise() async {
    _sessionId = 'projects/$botId/agent/sessions/$botName';

    final credentials = await _loadCredentials();

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(credentials),
      [DialogflowApi.cloudPlatformScope],
    );
    _dialogflowApi = DialogflowApi(client);
    _resource = _dialogflowApi.projects.agent.sessions;
  }

  @override
  Future<MessagePayload?> sendTextMessage(String message) async {
    final textInput = GoogleCloudDialogflowV2TextInput(
      text: message,
      languageCode: "en",
    );
    final queryInput = GoogleCloudDialogflowV2QueryInput(text: textInput);

    return await _sendMessage(
      request: GoogleCloudDialogflowV2DetectIntentRequest(
        queryInput: queryInput,
      ),
    );
  }

  @override
  Future<MessagePayload?> sendAudioMessage(String audioInput) async {
    final audioConfig = GoogleCloudDialogflowV2InputAudioConfig(
      audioEncoding: 'AUDIO_ENCODING_LINEAR_16',
      languageCode: 'en',
      sampleRateHertz: 16000,
    );
    final queryInput = GoogleCloudDialogflowV2QueryInput(
      audioConfig: audioConfig,
    );

    return await _sendMessage(
      request: GoogleCloudDialogflowV2DetectIntentRequest(
        queryInput: queryInput,
        inputAudio: audioInput,
      ),
    );
  }

  Future<MessagePayload?> _sendMessage({
    required GoogleCloudDialogflowV2DetectIntentRequest request,
  }) async {
    try {
      final response = await _resource.detectIntent(request, _sessionId);

      if (response.queryResult == null) return null;
      if (response.queryResult?.fulfillmentMessages == null) return null;
      if (response.queryResult!.fulfillmentMessages!.isEmpty) return null;

      final fulfillmentMessages = response.queryResult!.fulfillmentMessages!;
      final fulfillmentText = response.queryResult?.fulfillmentText;

      final outputAudio = response.outputAudio != null
          ? Audio(audio: response.outputAudio!)
          : null;

      final payloadJson = getPayloadJson(messages: fulfillmentMessages);

      final message = payloadJson != null
          ? MessagePayload.fromJson(payloadJson)
          : MessagePayload(
              text: fulfillmentText ?? MessagePayload.error().text,
            );

      return message.copyWith(audio: outputAudio);
    } on Exception catch (e) {
      return MessagePayload(text: 'Error occured: ${e.toString()}');
    }
  }

  Map<String, dynamic>? getPayloadJson({
    required List<GoogleCloudDialogflowV2IntentMessage> messages,
  }) {
    for (final message in messages) {
      if (message.payload != null) {
        return message.payload as Map<String, dynamic>;
      }
    }
    return null;
  }
}
