part of 'widgets.dart';

class EventSlotsSelection extends StatelessWidget {
  const EventSlotsSelection({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DateSlotCards(event: event),
        const SizedBox(height: 5),
        _TimeSlotCards(event: event),
      ],
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
            return _DateSlotCard(event: event, slot: slots[index]);
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
                  return _TimeSlotCard(
                      event: event, slot: slot, timeSlot: timeSlot);
                },
              ),
            )
          : const SizedBox(height: 0),
    );
  }
}

class _TimeSlotCard extends StatelessWidget {
  const _TimeSlotCard({
    required this.event,
    required this.slot,
    required this.timeSlot,
  });

  final Event event;
  final ChatEventSlot slot;
  final ChatEventTimeSlot timeSlot;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final time = timeSlot.timeSlot;
    final isSelected = timeSlot.isSelected;

    return GestureDetector(
      onTap: () => context.read<ChatbotBloc>().add(
            ChatbotMessageEventTimeSlotSelected(
              event: event,
              selectedEvent: slot,
              selectedTime: timeSlot,
            ),
          ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color:
                isSelected ? colorScheme.outline : colorScheme.primaryContainer,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Text(time.toString(), style: textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateSlotCard extends StatelessWidget {
  const _DateSlotCard({required this.event, required this.slot});

  final Event event;
  final ChatEventSlot slot;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final date = slot.date.dateSlot;
    final isSelected = slot.date.isSelected;

    return GestureDetector(
      onTap: () => context.read<ChatbotBloc>().add(
            ChatbotMessageEventSlotSelected(event: event, selectedEvent: slot),
          ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isSelected
                ? colorScheme.onPrimaryContainer
                : colorScheme.primaryContainer,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        color: isSelected ? colorScheme.primaryContainer : null,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text('${date.day}', style: textTheme.titleLarge),
              Text(
                getMonth(date).toUpperCase(),
                style: textTheme.labelSmall?.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
