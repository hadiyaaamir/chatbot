part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class EventsOnSubscribedEvent extends EventsEvent {}

final class EventsFilterChanged extends EventsEvent {
  const EventsFilterChanged({required this.filter});
  final EventsFilter filter;

  @override
  List<Object> get props => [filter];
}

class EventsSearchTextChanged extends EventsEvent {
  const EventsSearchTextChanged({required this.searchText});
  final String searchText;

  @override
  List<Object> get props => [searchText];
}
