part of 'models.dart';

class MessagePayload extends Equatable {
  const MessagePayload(
    this.text, {
    this.suggestions = const [],
    this.options,
    this.onlySuggestions = false,
  });

  final String text;
  final List<ChatSuggestion> suggestions;
  final List<ApiObject>? options;
  final bool onlySuggestions;

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

        switch (objectType) {
          case 'events':
            options = (objectData as List<dynamic>)
                .map((eventJson) => EventObject.fromJson(eventJson))
                .toList();

            break;
        }
      }
    }

    return MessagePayload(
      json['text'] as String? ?? '',
      suggestions: suggestions,
      options: options,
      onlySuggestions: json['onlySuggestions'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [text, suggestions, options, onlySuggestions];
}
