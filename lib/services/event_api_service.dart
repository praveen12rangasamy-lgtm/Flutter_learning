import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/event.dart';

class EventApiService {

  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  Future<List<Event>> fetchEvents() async {

    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load events',
      );
    }

    final List<dynamic> jsonData =
        jsonDecode(response.body);

    return jsonData.map<Event>((json) {

      return Event(
        id: json['id'] ?? 0,

        title: json['title'] ?? 'No title',

        description:
            json['body'] ?? 'No description',

        // Temporary values because
        // JSONPlaceholder doesn't provide
        // event-specific fields.
        location: 'Chennai',

        date: '15 September 2026',

        time: '10:00 AM',

        category: 'Workshop',
      );

    }).toList();
  }
}