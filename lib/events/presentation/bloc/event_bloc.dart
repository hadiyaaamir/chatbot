import 'package:bloc/bloc.dart';
import 'package:chatbot/events/events.dart';
import 'package:chatbot/utils/models/models.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(const EventInitial()) {
    on<EventSelectedDateUpdated>(_onSelectedDateUpdated);
    on<EventSelectedTimeSlotUpdated>(_onSelectedTimeSlotUpdated);
    on<EventSetDefaultSlot>(_onSetDefaultSlot);
  }

  void _onSelectedDateUpdated(
    EventSelectedDateUpdated event,
    Emitter<EventState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }

  void _onSelectedTimeSlotUpdated(
    EventSelectedTimeSlotUpdated event,
    Emitter<EventState> emit,
  ) {
    emit(state.copyWith(selectedTimeSlot: event.selectedTimeSlot));
  }

  void _onSetDefaultSlot(EventSetDefaultSlot event, Emitter<EventState> emit) {
    emit(
      state.copyWith(
        selectedDate: event.currentEvent.slots.first.date,
        selectedTimeSlot: event.currentEvent.slots.first.slots.first,
      ),
    );
  }
}
