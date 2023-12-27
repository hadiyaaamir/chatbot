part of 'widgets.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event, required this.searchText});

  final Event event;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(event.image, height: 180, fit: BoxFit.cover),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 95,
              child: EventDetailsBlock(
                event: event,
                searchText: searchText,
              ),
            ),
            const DottedDivider(spaceAbove: 5, spaceBelow: 10),
            Row(
              children: [
                Flexible(child: _MoreInfoButton(event: event)),
                const SizedBox(width: 10),
                Flexible(child: _BookNowButton(event: event))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BookNowButton extends StatelessWidget {
  const _BookNowButton({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<NavigationBloc>().add(
              NavigationIndexChanged(selectedIndex: NavigablePages.chat.index),
            );
        context.read<ChatbotBloc>().add(ChatbotMessageSent(
              attachUsername: true,
              message: ChatMessage(
                message: MessagePayload(
                  text: 'Give me the event card of event ${event.id}',
                  displayText: 'I want to book tickets for ${event.title} ',
                ),
              ),
            ));
      },
      child: const Text('Book Now'),
    );
  }
}

class _MoreInfoButton extends StatelessWidget {
  const _MoreInfoButton({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<NavigationBloc>().add(
              NavigationIndexChanged(selectedIndex: NavigablePages.chat.index),
            );
        context.read<ChatbotBloc>().add(
              ChatbotMessageSent(
                message: ChatMessage(
                  message: MessagePayload(
                    text: 'Tell me more about event ${event.id}',
                    displayText: 'Tell me more about ${event.title}',
                  ),
                ),
              ),
            );
      },
      child: const Text('Know More'),
    );
  }
}
