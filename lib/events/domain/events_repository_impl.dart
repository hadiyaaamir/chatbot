part of 'events_repository.dart';

class EventsRepositoryImpl extends EventsRepository {
  EventsRepositoryImpl({required super.eventsApi});

  @override
  Future<List<Event>> fetchEvents() async => await eventsApi.fetchEvents();
}
