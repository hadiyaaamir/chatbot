part of 'events_bloc.dart';

enum EventsStatus { initial, loading, success, failure }

class EventsState extends Equatable {
  const EventsState({required this.events, required this.status});

  final List<Event> events;
  final EventsStatus status;

  EventsState copyWith({List<Event>? events, EventsStatus? status}) {
    return EventsState(
      events: events ?? this.events,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [events, status];
}

final class EventsInitial extends EventsState {
  const EventsInitial() : super(events: const [], status: EventsStatus.initial);
}
