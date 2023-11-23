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
  final List<Option>? options;
  final bool onlySuggestions;

  static final Map<String, Function> typeParsers = {
    'events': (eventJson) => EventOption.fromJson(eventJson),
    'tickets': (ticketJson) => TicketOption.fromJson(ticketJson),
  };

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

        final parser = typeParsers[optionType];

        if (parser != null) {
          options = (objectData as List<dynamic>)
              .map((json) => parser(json) as Option)
              .toList();
        } else {
          throw UnimplementedError('Parser not implemented for $optionType');
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
