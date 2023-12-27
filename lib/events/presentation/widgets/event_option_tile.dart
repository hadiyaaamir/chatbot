part of 'widgets.dart';

class EventOptionTile extends OptionTile {
  const EventOptionTile(
      {super.key, required this.event, required this.usernameRequired})
      : super(option: event);

  final Event event;
  final bool usernameRequired;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageCarouselSlider(images: event.images),
            const SizedBox(height: 15),
            EventDetailsBlock(event: event),
            const DottedDivider(spaceAbove: 5),
            _ExpandibleBookingTile(
              event: event,
              usernameRequired: usernameRequired,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandibleBookingTile extends StatelessWidget {
  const _ExpandibleBookingTile({
    required this.event,
    required this.usernameRequired,
  });

  final Event event;
  final bool usernameRequired;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      childrenPadding: EdgeInsets.zero,
      collapsedIconColor: Theme.of(context).colorScheme.primary,
      shape: const Border(),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Book Now',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Flexible(
            child: _MoreInformationButton(event: event),
          ),
        ],
      ),
      children: [
        const SizedBox(height: 10),
        EventSlotsSelection(event: event),
        const SizedBox(height: 20),
        _BookTicketsButton(
          usernameRequired: usernameRequired,
          event: event,
        ),
      ],
    );
  }
}

class _MoreInformationButton extends StatelessWidget {
  const _MoreInformationButton({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      icon: const Icon(Icons.lightbulb_outline_rounded),
      label: const Text('Know More'),
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        side: BorderSide(color: colorScheme.secondary, width: 1.5),
      ),
      onPressed: () => context.read<ChatbotBloc>().add(
            ChatbotMessageSent(
              message: ChatMessage(
                message: MessagePayload(
                  text: 'Tell me more about event ${event.id}',
                  displayText: 'Tell me more about ${event.title}',
                ),
              ),
            ),
          ),
    );
  }
}

class _BookTicketsButton extends StatelessWidget {
  const _BookTicketsButton({
    required this.usernameRequired,
    required this.event,
  });

  final bool usernameRequired;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: event.selectedSlot != null
          ? () {
              final selectedDate = event.selectedSlot?.date.dateSlot;
              final stringDate =
                  selectedDate != null ? formatDate(selectedDate) : '';

              final selectedTime = event.selectedTimeSlot?.timeSlot;
              final startTime =
                  selectedTime != null ? selectedTime.startingTimeString : '';
              final endTime =
                  selectedTime != null ? selectedTime.endingTimeString : '';

              return context.read<ChatbotBloc>().add(
                    ChatbotMessageSent(
                      attachUsername: usernameRequired,
                      message: ChatMessage(
                        message: MessagePayload(
                          text: 'I want to book tickets for event ${event.id} '
                              'for $stringDate from $startTime to $endTime',
                          displayText:
                              'I want to book tickets for ${event.title} '
                              'for $stringDate from $startTime to $endTime',
                        ),
                      ),
                    ),
                  );
            }
          : null,
      child: const Text('Book Tickets'),
    );
  }
}
