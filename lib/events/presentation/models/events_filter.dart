import 'package:chatbot/events/events.dart';

enum EventsFilter { all, air, ground, sea }

extension EventsFilterX on EventsFilter {
  bool apply(Event event) {
    switch (this) {
      case EventsFilter.all:
        return true;
      case EventsFilter.air:
        return event.category.toLowerCase() == 'air';
      case EventsFilter.ground:
        return event.category.toLowerCase() == 'ground';
      case EventsFilter.sea:
        return event.category.toLowerCase() == 'sea';
    }
  }

  String get text {
    switch (this) {
      case EventsFilter.all:
        return 'All';
      case EventsFilter.air:
        return 'Air';
      case EventsFilter.ground:
        return 'Ground';
      case EventsFilter.sea:
        return 'Sea';
    }
  }

  Iterable<Event> applyAll(Iterable<Event> events) => events.where(apply);
}
