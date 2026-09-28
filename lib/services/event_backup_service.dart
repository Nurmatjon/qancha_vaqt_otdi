import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../models/event.dart';

class EventBackupService {
  String exportEvents(List<Event> events) {
    final data = {
      'version': 1,
      'events': events.map((event) => event.toJson()).toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(data);
  }

  List<Event> importEvents(String jsonString) {
    final decoded = jsonDecode(jsonString);

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid backup format');
    }

    if (decoded['version'] != 1) {
      throw const FormatException('Unsupported backup version');
    }

    final eventsData = decoded['events'];

    if (eventsData is! List) {
      throw const FormatException('Invalid events data');
    }

    final events = <Event>[];

    for (final item in eventsData) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Invalid event data');
      }

      events.add(Event.fromJson(item));
    }

    return events;
  }

  Future<String?> saveBackupFile(String jsonString) async {
    final result = await FilePicker.saveFile(
      dialogTitle: 'Save backup',
      fileName: 'qancha_vaqt_otdi_backup.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: utf8.encode(jsonString),
    );

    return result?.toString();
  }

  Future<String?> pickBackupFile() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (file == null) {
      return null;
    }

    final bytes = await file.readAsBytes();

    return utf8.decode(bytes);
  }
}