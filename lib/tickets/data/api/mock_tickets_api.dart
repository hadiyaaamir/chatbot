part of 'api.dart';

class MockTicketsApi extends TicketsApi {
  String baseUrl = 'https://65575a02bd4bcef8b6127c07.mockapi.io/tickets';

  @override
  Future<List<Ticket>> fetchTickets({required EventsApi eventsApi}) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final List<Event> events = await Future.wait(jsonData.map((data) async {
          final eventId = data['eventId'] as String;
          return await eventsApi.fetchEvent(eventId: eventId);
        }));

        final List<Ticket> tickets = jsonData.asMap().entries.map((entry) {
          final data = entry.value;
          final Event event = events[entry.key];
          return Ticket.fromJson(data).copyWith(event: event);
        }).toList();

        return tickets;
      } else {
        throw Exception(
          'Failed to fetch tickets: Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching tickets: $e');
    }
  }
}
