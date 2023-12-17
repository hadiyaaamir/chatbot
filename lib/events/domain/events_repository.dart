import 'package:chatbot/events/data/data.dart';

part 'events_repository_impl.dart';

abstract class EventsRepository {
  EventsRepository({required this.eventsApi});
  final EventsApi eventsApi;

  Future<List<Event>> fetchEvents();
}
