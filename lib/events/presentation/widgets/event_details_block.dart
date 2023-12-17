part of 'widgets.dart';

class EventDetailsBlock extends StatelessWidget {
  const EventDetailsBlock({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final range = event.dayRange;
    final days = event.numberOfDays;
    final daysString = '$days day${days > 1 ? 's' : ''}';

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$range • $daysString', style: textTheme.bodyMedium),
          const SizedBox(height: 5),
          Text(event.title, style: textTheme.titleLarge),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _LocationDetails(event: event)),
              _Price(price: event.price),
            ],
          ),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Text(
        '\$$price',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _LocationDetails extends StatelessWidget {
  const _LocationDetails({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
          child: Icon(
            Icons.location_on_rounded,
            color: Theme.of(context).colorScheme.outline,
            size: Theme.of(context).textTheme.bodyLarge?.fontSize,
          ),
        ),
        Expanded(
          child: Text(
            '${event.city}, ${event.country}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
