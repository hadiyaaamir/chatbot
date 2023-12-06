part of 'event_bloc.dart';

class EventState extends Equatable {
  const EventState({
    required this.selectedDate,
    required this.selectedTimeSlot,
  });

  final DateTime? selectedDate;
  final TimeSlot? selectedTimeSlot;

  EventState copyWith({DateTime? selectedDate, TimeSlot? selectedTimeSlot}) {
    return EventState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
    );
  }

  @override
  List<Object?> get props => [selectedDate, selectedTimeSlot];
}

final class EventInitial extends EventState {
  const EventInitial({super.selectedDate, super.selectedTimeSlot});
}
