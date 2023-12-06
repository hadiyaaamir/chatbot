part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventSelectedDateUpdated extends EventEvent {
  const EventSelectedDateUpdated({required this.selectedDate});
  final DateTime selectedDate;

  @override
  List<Object> get props => [selectedDate];
}

class EventSelectedTimeSlotUpdated extends EventEvent {
  const EventSelectedTimeSlotUpdated({required this.selectedTimeSlot});
  final TimeSlot selectedTimeSlot;

  @override
  List<Object> get props => [selectedTimeSlot];
}

class EventSetDefaultSlot extends EventEvent {
  const EventSetDefaultSlot({required this.currentEvent});
  final Event currentEvent;
}
