import 'package:chatbot/events/events.dart';
import 'package:chatbot/navigation/navigation.dart';
import 'package:chatbot/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        List<Event> filteredEvents = state.filteredEvents.toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${state.filter.text} Events',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 415),
              child: state.status == EventsStatus.success
                  ? filteredEvents.isNotEmpty
                      ? _NonEmptyList(filteredEvents: filteredEvents)
                      : _EmptyList(
                          currentFilter: state.filter.text,
                          searchText: state.searchText,
                        )
                  : const CustomProgessIndicator(),
            )
          ],
        );
      },
    );
  }
}

class _NonEmptyList extends StatelessWidget {
  const _NonEmptyList({required this.filteredEvents});

  final List<Event> filteredEvents;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemExtent: MediaQuery.of(context).size.width - 90,
      itemBuilder: (context, index) {
        return EventTile(event: filteredEvents[index]);
      },
      itemCount: filteredEvents.length,
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({required this.currentFilter, required this.searchText});

  final String currentFilter;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          searchText.isEmpty
              ? 'No $currentFilter Events currently available'
              : 'No results found for \'$searchText\'',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox(width: 0)),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: searchText.isEmpty
                    ? const _ViewAllEventsButton()
                    : const _ClearSearchButton(),
              ),
            ),
            const Flexible(flex: 1, child: SizedBox(width: 0)),
          ],
        ),
      ],
    );
  }
}

class _ViewAllEventsButton extends StatelessWidget {
  const _ViewAllEventsButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context
          .read<EventsBloc>()
          .add(const EventsFilterChanged(filter: EventsFilter.all)),
      child: const Text('View All Events'),
    );
  }
}

class _ClearSearchButton extends StatelessWidget {
  const _ClearSearchButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context
          .read<EventsBloc>()
          .add(const EventsSearchTextChanged(searchText: '')),
      child: const Text('Clear Search'),
    );
  }
}
