import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/mock_data.dart';
import '../../../core/services/api_routes.dart';
import '../models/event.dart';

class EventApiService {
  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiRoutes.events),
          )
          .timeout(
            const Duration(seconds: 4),
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.isNotEmpty) {
          return jsonData.take(15).map<Event>((json) {
            final int id = json['id'] is int
                ? json['id']
                : int.tryParse(json['id'].toString()) ?? 0;

            final String title = json['title'] != null
                ? json['title'].toString()
                : 'Tech & Community Event';

            final String body = json['body'] != null
                ? json['body'].toString()
                : 'Join us for this exciting interactive event and connect with peers.';

            return Event(
              id: id,
              title: title,
              description: body,
              location: 'Chennai',
              date: '15 September 2026',
              time: '10:00 AM',
              category: id % 2 == 0 ? 'Conference' : 'Workshop',
            );
          }).toList();
        }
      }
    } catch (error) {
      debugPrint('EventApiService: Network call failed ($error), using fallback events.');
    }

    // Return rich offline-ready mock events so user never sees a broken screen
    return MockData.sampleEvents;
  }
}
