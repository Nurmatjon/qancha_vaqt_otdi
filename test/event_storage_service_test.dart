import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qancha_vaqt_otdi/models/event.dart';
import 'package:qancha_vaqt_otdi/services/event_storage_service.dart';

void main() {
  late EventStorageService storageService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    storageService = EventStorageService();
  });

  test('bo‘sh storage bo‘lsa, bo‘sh ro‘yxat qaytaradi', () async {
    final events = await storageService.loadEvents();

    expect(events, isEmpty);
  });

  test('bitta event saqlanadi va qayta yuklanadi', () async {
    final event = Event(
      title: 'O‘g‘lim tug‘ilgan kuni',
      dateTime: DateTime(2020, 6, 13, 15, 1),
      description: 'Oilamizga yangi quvonch keldi',
    );

    await storageService.saveEvents([event]);

    final loadedEvents = await storageService.loadEvents();

    expect(loadedEvents, hasLength(1));
    expect(loadedEvents.first.title, event.title);
    expect(loadedEvents.first.dateTime, event.dateTime);
    expect(loadedEvents.first.description, event.description);
  });

  test('bir nechta event saqlanadi va qayta yuklanadi', () async {
    final events = [
      Event(
        title: 'O‘g‘lim tug‘ilgan kuni',
        dateTime: DateTime(2020, 6, 13, 15, 1),
        description: 'Birinchi event',
      ),
      Event(
        title: 'Men tug‘ilgan kun',
        dateTime: DateTime(1974, 7, 21, 15, 2),
        description: 'Ikkinchi event',
      ),
    ];

    await storageService.saveEvents(events);

    final loadedEvents = await storageService.loadEvents();

    expect(loadedEvents, hasLength(2));
    expect(loadedEvents[0].title, events[0].title);
    expect(loadedEvents[1].title, events[1].title);
  });

  test('eventlar ro‘yxati yangilanganda yangi qiymatlar saqlanadi', () async {
    final originalEvent = Event(
      title: 'Eski nom',
      dateTime: DateTime(2020, 6, 13, 15, 1),
      description: 'Eski izoh',
    );

    final editedEvent = Event(
      title: 'Yangi nom',
      dateTime: DateTime(2021, 7, 14, 16, 30),
      description: 'Yangi izoh',
    );

    await storageService.saveEvents([originalEvent]);
    await storageService.saveEvents([editedEvent]);

    final loadedEvents = await storageService.loadEvents();

    expect(loadedEvents, hasLength(1));
    expect(loadedEvents.first.title, 'Yangi nom');
    expect(loadedEvents.first.dateTime, DateTime(2021, 7, 14, 16, 30));
    expect(loadedEvents.first.description, 'Yangi izoh');
  });

  test('eventlar ro‘yxati bo‘sh saqlansa, keyin bo‘sh ro‘yxat yuklanadi', () async {
    final event = Event(
      title: 'O‘chiriladigan event',
      dateTime: DateTime(2020, 6, 13, 15, 1),
      description: '',
    );

    await storageService.saveEvents([event]);
    await storageService.saveEvents([]);

    final loadedEvents = await storageService.loadEvents();

    expect(loadedEvents, isEmpty);
  });

  test('noto‘g‘ri JSON yozuvi boshqa eventlarni buzmaydi', () async {
    SharedPreferences.setMockInitialValues({
      'events': [
        'noto‘g‘ri json',
        '{"title":"To‘g‘ri event","dateTime":"2020-06-13T15:01:00.000","description":"Test"}',
      ],
    });

    final loadedEvents = await storageService.loadEvents();

    expect(loadedEvents, hasLength(1));
    expect(loadedEvents.first.title, 'To‘g‘ri event');
  });
}