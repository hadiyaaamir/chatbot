part of 'widgets.dart';

class EventDetailsBlock extends StatelessWidget {
  const EventDetailsBlock({
    super.key,
    required this.event,
    this.searchText = '',
  });

  final Event event;
  final String searchText;

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
          HighlightedSearchText(
            searchText: searchText,
            child: Text(event.title, style: textTheme.titleLarge),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LocationDetails(event: event, searchText: searchText),
              ),
              ColoredTextTag(text: '\$${event.price}'),
            ],
          ),
        ],
      ),
    );
  }
}

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key, required this.event, this.searchText = ''});

  final Event event;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
          child: Icon(
            Icons.location_on_rounded,
            color: Theme.of(context).colorScheme.outline,
            size: Theme.of(context).textTheme.bodyLarge?.fontSize,
          ),
        ),
        Flexible(
          child: HighlightedSearchText(
            searchText: searchText,
            child: Text(
              '${event.city}, ${event.country}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }
}
