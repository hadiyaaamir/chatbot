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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(event.image, height: 150, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventDetailsBlock(event: event),
                const SizedBox(height: 10),
                EventSlotsSelection(event: event),
                const SizedBox(height: 15),
                _MoreInformationButton(event: event),
                _BookTicketsButton(
                  usernameRequired: usernameRequired,
                  event: event,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreInformationButton extends StatelessWidget {
  const _MoreInformationButton({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'More Information',
      backgroundColor: Theme.of(context).colorScheme.background,
      outlineColor: Theme.of(context).colorScheme.inversePrimary,
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
    return CustomButton(
      label: 'Book Tickets',
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
    );
  }
}
