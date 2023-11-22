part of 'models.dart';

class MessagePayload extends Equatable {
  const MessagePayload(
    this.text, {
    this.displayText,
    this.suggestions = const [],
    this.options,
    this.onlySuggestions = false,
  });

  final String text;
  final String? displayText;

  final List<ChatSuggestion> suggestions;
  final List<ApiObject>? options;
  final bool onlySuggestions;

  static final Map<String, Function> typeParsers = {
    'events': (eventJson) => EventObject.fromJson(eventJson)
  };

  factory MessagePayload.fromJson(Map<String, dynamic> json) {
    List<ChatSuggestion> suggestions = [];
    List<ApiObject>? options;

    if (json['suggestions'] != null) {
      suggestions = List<ChatSuggestion>.from(
        (json['suggestions'] as List<dynamic>).map(
          (suggestionJson) => ChatSuggestion.fromJson(
            suggestionJson as Map<String, dynamic>,
          ),
        ),
      );
    }

    if (json['objects'] != null) {
      Map<String, dynamic> objectsJson = json['objects'];

      if (objectsJson.isNotEmpty) {
        String objectType = objectsJson.keys.first;
        dynamic objectData = objectsJson[objectType];

        final parser = typeParsers[objectType];

        if (parser != null) {
          options = (objectData as List<dynamic>)
              .map((json) => parser(json) as ApiObject)
              .toList();
        } else {
          throw UnimplementedError('Parser not implemented for $objectType');
        }
      }
    }

    return MessagePayload(
      json['text'] as String? ?? '',
      displayText: json['displayText'] as String?,
      suggestions: suggestions,
      options: options,
      onlySuggestions: json['onlySuggestions'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        text,
        displayText,
        suggestions,
        options,
        onlySuggestions,
      ];
}
