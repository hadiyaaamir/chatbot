import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/events/events.dart';
import 'package:flutter/material.dart';

class EventsFilterButtons extends StatelessWidget {
  const EventsFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EventsFilter> filters = EventsFilter.values.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(
          filters.length,
          (index) => _FilterButton(filter: filters[index]),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.filter});

  final EventsFilter filter;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<EventsBloc, EventsState>(
      buildWhen: (previous, current) => previous.filter != current.filter,
      builder: (context, state) {
        final bool isSelected = state.filter == filter;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextButton(
            onPressed: () => context.read<EventsBloc>().add(
                  EventsFilterChanged(filter: filter),
                ),
            style: TextButton.styleFrom(
              backgroundColor: isSelected
                  ? colorScheme.secondary
                  : colorScheme.primaryContainer,
              foregroundColor: isSelected
                  ? colorScheme.onSecondary
                  : colorScheme.onPrimaryContainer,
            ),
            child: Text(filter.text),
          ),
        );
      },
    );
  }
}
