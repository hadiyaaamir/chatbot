import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/events/events.dart';
import 'package:chatbot/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EventsFilterButtons extends StatelessWidget {
  const EventsFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EventsFilter> filters = EventsFilter.values.toList();

    return Row(
      children: List.generate(
        filters.length,
        (index) => BlocBuilder<EventsBloc, EventsState>(
          buildWhen: (previous, current) => previous.filter != current.filter,
          builder: (context, state) {
            return FilterButton(
              isSelected: state.filter == filters[index],
              label: filters[index].text,
              onPressed: () => context
                  .read<EventsBloc>()
                  .add(EventsFilterChanged(filter: filters[index])),
            );
          },
        ),
      ),
    );
  }
}
