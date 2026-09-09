import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String registrationsKey = 'event_registrations';

  Future<void> saveRegistration({
    required int eventId,
    required String eventTitle,
    required String name,
    required String email,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> existingRegistrations =
        prefs.getStringList(registrationsKey) ?? [];

    final Map<String, dynamic> registration = {
      'eventId': eventId,
      'eventTitle': eventTitle,
      'name': name,
      'email': email,
      'phone': phone,
      'registeredAt': DateTime.now().toIso8601String(),
    };

    final String jsonString = jsonEncode(registration);
    existingRegistrations.add(jsonString);

    await prefs.setStringList(
      registrationsKey,
      existingRegistrations,
    );
  }

  Future<List<Map<String, dynamic>>> getRegistrations() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> savedData =
        prefs.getStringList(registrationsKey) ?? [];

    return savedData.map((item) {
      return jsonDecode(item) as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearRegistrations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(registrationsKey);
  }
}
