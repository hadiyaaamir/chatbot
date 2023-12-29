part of 'domain.dart';

class TicketsRepositoryImpl extends TicketsRepository {
  TicketsRepositoryImpl({required super.ticketsApi, required super.eventsApi});

  @override
  Future<List<Ticket>> fetchTickets({required String username}) {
    return ticketsApi.fetchTickets(eventsApi: eventsApi, username: username);
  }
}
