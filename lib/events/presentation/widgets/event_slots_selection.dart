part of 'widgets.dart';

class EventSlotsSelection extends StatelessWidget {
  const EventSlotsSelection({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text('Select a Date', style: textTheme.labelLarge),
        ),
        _DateSlotCards(event: event),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text('Select a Time Slot', style: textTheme.labelLarge),
        ),
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
                    event: event,
                    slot: slot,
                    timeSlot: timeSlot,
                  );
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
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color:
            isSelected ? colorScheme.secondary : colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            children: [
              Text(
                time.toString(),
                style: textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? colorScheme.onSecondary
                      : colorScheme.onBackground,
                ),
              ),
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
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color:
            isSelected ? colorScheme.secondary : colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            children: [
              Text(
                '${date.day}',
                style: textTheme.titleLarge?.copyWith(
                  color: isSelected ? colorScheme.onSecondary : null,
                ),
              ),
              Text(
                getMonth(date),
                style: textTheme.labelMedium?.copyWith(
                  color: isSelected ? colorScheme.onSecondary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
