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
      onPressed: () => context.read<ChatbotBloc>().add(
            ChatbotMessageSent(
              attachUsername: usernameRequired,
              message: ChatMessage(
                message: MessagePayload(
                  'I want to book tickets for event ${event.id}',
                  displayText: 'I want to book tickets for ${event.title}',
                ),
              ),
            ),
          ),
    );
  }
}
