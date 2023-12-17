import 'dart:convert';

import 'package:chatbot/events/events.dart';
import 'package:http/http.dart' as http;

part 'mock_events_api.dart';

abstract class EventsApi {
  Future<List<Event>> fetchEvents();
}
