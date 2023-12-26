part of 'events_bloc.dart';

enum EventsStatus { initial, loading, success, failure }

class EventsState extends Equatable {
  const EventsState({
    required this.events,
    required this.filter,
    required this.status,
    required this.searchText,
  });

  final List<Event> events;
  final EventsFilter filter;
  final EventsStatus status;
  final String searchText;

  EventsState copyWith({
    List<Event>? events,
    EventsFilter? filter,
    EventsStatus? status,
    String? searchText,
  }) {
    return EventsState(
      events: events ?? this.events,
      filter: filter ?? this.filter,
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
    );
  }

  Iterable<Event> get filteredEvents => filter
      .applyAll(events)
      .where((event) => event.matchesSearch(searchText))
      .toList();

  @override
  List<Object> get props => [events, filter, status, searchText];
}

final class EventsInitial extends EventsState {
  const EventsInitial()
      : super(
          events: const [],
          filter: EventsFilter.all,
          status: EventsStatus.initial,
          searchText: '',
        );
}
