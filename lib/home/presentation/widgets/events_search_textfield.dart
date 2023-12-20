import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/events/events.dart';
import 'package:flutter/material.dart';

class EventsSearchTextField extends StatefulWidget {
  const EventsSearchTextField({super.key});

  @override
  State<EventsSearchTextField> createState() => _EventsSearchTextFieldState();
}

class _EventsSearchTextFieldState extends State<EventsSearchTextField> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventsBloc, EventsState>(
      listenWhen: (previous, current) =>
          previous.searchText != current.searchText,
      listener: (context, state) {
        if (state.searchText.isEmpty) searchController.clear();
      },
      child: TextField(
        controller: searchController,
        style: Theme.of(context).textTheme.titleSmall,
        decoration: const InputDecoration(
          hintText: 'Search events',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (searchText) => context.read<EventsBloc>().add(
              EventsSearchTextChanged(searchText: searchText),
            ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
