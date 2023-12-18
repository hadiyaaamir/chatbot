part of 'events_bloc.dart';

enum EventsStatus { initial, loading, success, failure }

class EventsState extends Equatable {
  const EventsState({
    required this.events,
    required this.filter,
    required this.status,
  });

  final List<Event> events;
  final EventsFilter filter;
  final EventsStatus status;

  EventsState copyWith({
    List<Event>? events,
    EventsFilter? filter,
    EventsStatus? status,
  }) {
    return EventsState(
      events: events ?? this.events,
      filter: filter ?? this.filter,
      status: status ?? this.status,
    );
  }

  Iterable<Event> get filteredEvents => filter.applyAll(events);

  @override
  List<Object> get props => [events, filter, status];
}

final class EventsInitial extends EventsState {
  const EventsInitial()
      : super(
          events: const [],
          filter: EventsFilter.all,
          status: EventsStatus.initial,
        );
}
