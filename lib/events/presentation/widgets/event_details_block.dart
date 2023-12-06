part of 'widgets.dart';

class EventDetailsBlock extends StatelessWidget {
  const EventDetailsBlock({
    super.key,
    required this.event,
    this.smallerPrice = false,
  });

  final Event event;
  final bool smallerPrice;

  @override
  Widget build(BuildContext context) {
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
              _Price(price: event.price, smallerPrice: smallerPrice),
            ],
          ),
        ),
        _LocationDetails(event: event),
      ],
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.price, required this.smallerPrice});

  final int price;
  final bool smallerPrice;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$price',
      style: smallerPrice
          ? Theme.of(context).textTheme.titleMedium
          : Theme.of(context).textTheme.titleLarge,
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
    final range = event.dayRange;
    final days = event.numberOfDays;
    final daysString = '$days day${days > 1 ? 's' : ''}';

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(event.title, style: textTheme.titleMedium),
        const SizedBox(height: 5),
        Text('$range ($daysString)', style: textTheme.bodySmall),
      ],
    );
  }
}
