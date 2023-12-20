import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/events/events.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({required EventsRepository eventsRepository})
      : _eventsRepository = eventsRepository,
        super(const EventsInitial()) {
    on<EventsOnSubscribedEvent>(_onSubscription);
    on<EventsFilterChanged>(_onFilterChanged);
    on<EventsSearchTextChanged>(_onSearchTextChanged);
  }

  final EventsRepository _eventsRepository;

  Future<void> _onSubscription(
    EventsOnSubscribedEvent event,
    Emitter<EventsState> emit,
  ) async {
    try {
      emit(state.copyWith(events: [], status: EventsStatus.loading));
      final events = await _eventsRepository.fetchEvents();
      emit(state.copyWith(events: events, status: EventsStatus.success));
    } catch (e) {
      emit(state.copyWith(events: [], status: EventsStatus.failure));
    }
  }

  void _onFilterChanged(EventsFilterChanged event, Emitter<EventsState> emit) {
    emit(state.copyWith(filter: event.filter));
  }

  void _onSearchTextChanged(
    EventsSearchTextChanged event,
    Emitter<EventsState> emit,
  ) {
    emit(state.copyWith(searchText: event.searchText));
  }
}
