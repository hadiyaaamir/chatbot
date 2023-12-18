import 'package:chatbot/events/events.dart';
import 'package:chatbot/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        List<Event> filteredEvents = state.filteredEvents.toList();

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '${state.filter.text} Events',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 415),
                child: filteredEvents.isNotEmpty
                    ? _NonEmptyList(filteredEvents: filteredEvents)
                    : _EmptyList(currentFilter: state.filter.text),
              )
            ],
          ),
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
  const _EmptyList({required this.currentFilter});

  final String currentFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No $currentFilter Events currently available',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox(width: 0)),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: () => context.read<EventsBloc>().add(
                        const EventsFilterChanged(filter: EventsFilter.all),
                      ),
                  // style: OutlinedButton.styleFrom(
                  //   foregroundColor: Theme.of(context).colorScheme.secondary,
                  //   // side: BorderSide(
                  //   //     color: Theme.of(context).colorScheme.secondary),
                  // ),
                  child: const Text('View All Events'),
                ),
              ),
            ),
            const Flexible(flex: 1, child: SizedBox(width: 0)),
          ],
        ),
      ],
    );
  }
}
