import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/event.dart';

class EventStorageService {
  static const String _eventsKey = 'events';

  Future<List<Event>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();

    final savedEvents = prefs.getStringList(_eventsKey);

    if (savedEvents == null) {
      return [];
    }

    final loadedEvents = <Event>[];

    for (final item in savedEvents) {
      try {
        final json = jsonDecode(item) as Map<String, dynamic>;
        loadedEvents.add(Event.fromJson(json));
      } catch (_) {
        // Noto‘g‘ri yozuv bo‘lsa, uni tashlab ketamiz.
      }
    }

    return loadedEvents;
  }

  Future<void> saveEvents(List<Event> events) async {
    final prefs = await SharedPreferences.getInstance();

    final encodedEvents = events
        .map((event) => jsonEncode(event.toJson()))
        .toList();

    await prefs.setStringList(_eventsKey, encodedEvents);
  }
}