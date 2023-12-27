part of 'events_api.dart';

class MockEventsApi extends EventsApi {
  final baseApiUrl =
      'https://65575a02bd4bcef8b6127c07.mockapi.io/ticketbooking/events';

  @override
  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(baseApiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load events. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }

  @override
  Future<Event> fetchEvent({required String eventId}) async {
    try {
      final response = await http.get(Uri.parse('$baseApiUrl/$eventId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> eventData = json.decode(response.body);
        return Event.fromJson(eventData);
      } else {
        throw Exception(
          'Failed to fetch event. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching event: $e');
    }
  }
}
