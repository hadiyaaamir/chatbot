part of 'widgets.dart';

class EventDetailsBlock extends StatelessWidget {
  const EventDetailsBlock({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NameAndDateBlock(event: event),
              Text('\$${event.price}', style: textTheme.titleLarge),
            ],
          ),
        ),
        _LocationDetails(event: event),
      ],
    );
  }
}

class _LocationDetails extends StatelessWidget {
  const _LocationDetails({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: Theme.of(context).textTheme.bodyLarge?.fontSize,
        ),
        Expanded(child: Text('${event.city}, ${event.country}')),
      ],
    );
  }
}

class _NameAndDateBlock extends StatelessWidget {
  const _NameAndDateBlock({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(event.title, style: textTheme.titleMedium),
        Text(
          DateFormat('dd MMM yyyy').format(event.date),
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
