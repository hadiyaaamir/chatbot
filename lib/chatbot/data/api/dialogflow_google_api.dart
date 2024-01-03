import 'dart:convert';

import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/utils/constants.dart';

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
        queryParams: GoogleCloudDialogflowV2QueryParameters(
          payload: {'username': kHardcodedUsername},
        ),
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
        queryParams: GoogleCloudDialogflowV2QueryParameters(
          payload: {'username': kHardcodedUsername},
        ),
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

      if (response.queryResult == null ||
          response.queryResult?.fulfillmentMessages == null) return null;
      if (response.queryResult!.fulfillmentMessages!.isEmpty) return null;

      final fulfillmentMessages = response.queryResult!.fulfillmentMessages!;
      final fulfillmentText = response.queryResult?.fulfillmentText;

      final outputAudio = response.outputAudio != null
          ? Audio(audio: response.outputAudio!)
          : null;

      for (final message in fulfillmentMessages) {
        if (message.payload != null) {
          return MessagePayload.fromJson(
            message.payload as Map<String, dynamic>,
          ).copyWith(audio: outputAudio);
        }
      }

      return MessagePayload(
        text: fulfillmentText ?? MessagePayload.error().text,
      ).copyWith(audio: outputAudio);
    } on Exception catch (e) {
      return MessagePayload(text: 'Error occured: ${e.toString()}');
    }
  }
}
