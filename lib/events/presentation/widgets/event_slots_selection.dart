part of 'widgets.dart';

class EventSlotsSelection extends StatelessWidget {
  const EventSlotsSelection({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_DateSlotCards(event: event), _TimeSlotCards(event: event)],
    );
  }
}

class _DateSlotCards extends StatelessWidget {
  const _DateSlotCards({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final slots = event.slots;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          slots.length,
          (index) {
            final date = slots[index].date;
            return GestureDetector(
              onTap: () => context.read<ChatbotBloc>().add(
                    ChatbotMessageEventSlotSelected(
                      event: event,
                      selectedEvent: slots[index],
                    ),
                  ),
              child: Card(
                child: Text(
                  '${formatDate(date.dateSlot)}${date.isSelected ? '*' : ''}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TimeSlotCards extends StatelessWidget {
  const _TimeSlotCards({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final slot = event.selectedSlot;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: slot != null
          ? Row(
              children: List.generate(
                slot.timeSlots.length,
                (index) {
                  final timeSlot = slot.timeSlots[index];
                  return GestureDetector(
                    onTap: () => context.read<ChatbotBloc>().add(
                          ChatbotMessageEventTimeSlotSelected(
                            event: event,
                            selectedEvent: slot,
                            selectedTime: timeSlot,
                          ),
                        ),
                    child: Card(
                      child: Text(
                        '${timeSlot.timeSlot}${timeSlot.isSelected ? '*' : ''}',
                      ),
                    ),
                  );
                },
              ),
            )
          : const SizedBox(height: 0),
    );
  }
}
