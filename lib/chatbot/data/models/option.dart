part of 'models.dart';

abstract class Option extends Equatable {
  const Option();

  factory Option.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  static final Map<String, Function> _typeParsers = {
    'events': (eventJson) => Event.fromJson(eventJson),
    'tickets': (ticketJson) => Ticket.fromJson(ticketJson),
  };

  static getParser(String key) {
    final parser = _typeParsers[key];
    return parser ??
        (throw UnimplementedError('Parser not implemented for $key'));
  }
}
