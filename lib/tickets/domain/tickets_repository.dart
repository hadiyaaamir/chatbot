part of 'domain.dart';

abstract class TicketsRepository {
  const TicketsRepository({required this.ticketsApi, required this.eventsApi});

  final TicketsApi ticketsApi;
  final EventsApi eventsApi;

  Future<List<Ticket>> fetchTickets();
}
