part of 'api.dart';

abstract class TicketsApi {
  Future<List<Ticket>> fetchTickets({required EventsApi eventsApi});
}
