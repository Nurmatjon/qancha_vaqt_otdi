import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qancha_vaqt_otdi/models/event.dart';
import 'package:qancha_vaqt_otdi/services/event_backup_service.dart';

void main() {
  test('exportEvents creates valid backup JSON', () {
    final service = EventBackupService();

    final events = [
      Event(
        title: 'Tug‘ilgan kun',
        dateTime: DateTime(1990, 5, 10, 12, 30),
        description: 'Test event',
      ),
    ];

    final json = service.exportEvents(events);
    final data = jsonDecode(json) as Map<String, dynamic>;

    expect(data['version'], 1);
    expect(data['events'], isA<List>());

    final exportedEvents = data['events'] as List;

    expect(exportedEvents.length, 1);
    expect(exportedEvents.first['title'], 'Tug‘ilgan kun');
    expect(exportedEvents.first['description'], 'Test event');
  });

  test('importEvents restores events from backup JSON', () {
    final service = EventBackupService();

    const backupJson = '''
  {
    "version": 1,
    "events": [
      {
        "title": "Test event",
        "dateTime": "2020-01-15T10:30:00.000",
        "description": "Imported event",
        "category": "general"
      }
    ]
  }
  ''';

    final events = service.importEvents(backupJson);

    expect(events.length, 1);
    expect(events.first.title, 'Test event');
    expect(events.first.dateTime, DateTime(2020, 1, 15, 10, 30));
    expect(events.first.description, 'Imported event');
  });

  test('importEvents rejects unsupported backup version', () {
    final service = EventBackupService();

    const backupJson = '''
  {
    "version": 99,
    "events": []
  }
  ''';

    expect(
      () => service.importEvents(backupJson),
      throwsA(isA<FormatException>()),
    );
  });
}