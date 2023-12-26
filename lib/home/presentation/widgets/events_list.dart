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
            _EventsTitle(currentFilter: state.filter.text),
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

class _EventsTitle extends StatelessWidget {
  const _EventsTitle({required this.currentFilter});

  final String currentFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        '$currentFilter Events',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
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
    return searchText.isEmpty
        ? EmptyTextAndButtonList(
            text: 'No $currentFilter Events currently available',
            button: OutlinedButton(
              onPressed: () => context
                  .read<EventsBloc>()
                  .add(const EventsFilterChanged(filter: EventsFilter.all)),
              child: const Text('View All Events'),
            ),
          )
        : EmptyTextAndButtonList(
            text: 'No results found for \'$searchText\'',
            button: OutlinedButton(
              onPressed: () => context
                  .read<EventsBloc>()
                  .add(const EventsSearchTextChanged(searchText: '')),
              child: const Text('Clear Search'),
            ),
          );
  }
}
