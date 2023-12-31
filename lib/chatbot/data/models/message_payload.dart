part of 'models.dart';

class MessagePayload extends Equatable {
  const MessagePayload({
    this.text = '',
    this.displayText,
    this.urlText,
    this.suggestions = const [],
    this.options,
    this.onlySuggestions = false,
    this.requireUsername = false,
    this.audio,
  });

  factory MessagePayload.error() {
    return const MessagePayload(text: 'Unexpected error occured');
  }

  factory MessagePayload.fallback() {
    return const MessagePayload(text: 'Sorry, can you please say that again?');
  }

  final String text;
  final String? urlText;
  final String? displayText;

  final List<ChatSuggestion> suggestions;
  final List<Option>? options;
  final bool onlySuggestions;
  final bool requireUsername;

  final Audio? audio;

  bool get isAudioMessage => text.isEmpty && audio != null;
  bool get isTextMessage => text.isNotEmpty;
  bool get isEmpty => text.isEmpty && audio == null;

  MessagePayload playAudio() => copyWith(audio: audio?.startPlaying());
  MessagePayload stopAudio() => copyWith(audio: audio?.stopPlaying());

  factory MessagePayload.fromJson(Map<String, dynamic> json) {
    List<ChatSuggestion> suggestions = [];
    List<Option>? options;

    if (json['suggestions'] != null) {
      suggestions = List<ChatSuggestion>.from(
        (json['suggestions'] as List<dynamic>).map(
          (suggestionJson) => ChatSuggestion.fromJson(
            suggestionJson as Map<String, dynamic>,
          ),
        ),
      );
    }

    if (json['options'] != null) {
      Map<String, dynamic> optionsJson = json['options'];

      if (optionsJson.isNotEmpty) {
        String optionType = optionsJson.keys.first;
        dynamic objectData = optionsJson[optionType];

        final parser = Option.getParser(optionType);

        if (parser != null) {
          options = objectData is List
              ? objectData.map((json) => parser(json) as Option).toList()
              : [parser(objectData) as Option];
        } else {
          throw UnimplementedError('Parser not implemented for $optionType');
        }
      }
    }

    return MessagePayload(
      text: json['text'] as String? ?? '',
      displayText: json['displayText'] as String?,
      urlText: json['urlText'] as String?,
      suggestions: suggestions,
      options: options,
      onlySuggestions: json['onlySuggestions'] as bool? ?? false,
      requireUsername: json['requireUsername'] as bool? ?? false,
    );
  }

  MessagePayload copyWith({
    String? text,
    String? displayText,
    String? urlText,
    List<ChatSuggestion>? suggestions,
    List<Option>? options,
    bool? onlySuggestions,
    bool? requireUsername,
    Audio? audio,
  }) {
    return MessagePayload(
      text: text ?? this.text,
      displayText: displayText ?? this.displayText,
      urlText: urlText ?? this.urlText,
      suggestions: suggestions ?? this.suggestions,
      options: options ?? this.options,
      onlySuggestions: onlySuggestions ?? this.onlySuggestions,
      requireUsername: requireUsername ?? this.requireUsername,
      audio: audio ?? this.audio,
    );
  }

  @override
  List<Object?> get props => [
        text,
        displayText,
        urlText,
        suggestions,
        options,
        onlySuggestions,
        requireUsername,
        audio,
      ];
}
