import 'package:chatbot/events/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Air Events',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 415),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemExtent: MediaQuery.of(context).size.width - 90,
                  itemBuilder: (context, index) {
                    return EventTile(event: state.events[index]);
                  },
                  itemCount: state.events.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
