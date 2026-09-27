import 'package:flutter_test/flutter_test.dart';

import 'package:qancha_vaqt_otdi/l10n/app_localizations.dart';
import 'package:qancha_vaqt_otdi/models/birthday_insights.dart';
import 'package:qancha_vaqt_otdi/models/elapsed_time.dart';
import 'package:qancha_vaqt_otdi/models/event.dart';
import 'package:qancha_vaqt_otdi/models/event_category.dart';
import 'package:qancha_vaqt_otdi/services/event_share_service.dart';
import 'dart:ui';

void main() {
  late AppLocalizations l10n;

  setUp(() {
    l10n = lookupAppLocalizations(const Locale('uz'));
  });

  test('oddiy event uchun share matni yaratiladi', () {
    final event = Event(
      title: 'Test voqea',
      dateTime: DateTime(2025, 6, 15, 14, 30),
      description: '',
    );

    const elapsed = ElapsedTime(
      years: 1,
      months: 2,
      days: 3,
      hours: 4,
      minutes: 5,
      seconds: 6,
    );

    final result = EventShareService.buildShareText(
      event: event,
      elapsed: elapsed,
      l10n: l10n,
    );

    expect(result, contains('Test voqea'));
    expect(result, contains('1 yil'));
    expect(result, contains('2 oy'));
    expect(result, contains('3 kun'));
    expect(result, contains('04:05:06'));
    expect(result, contains('15.06.2025 14:30'));
    expect(result, isNot(contains('Qiziqarli statistika')));
  });

  test('birthday event uchun statistika share matniga qo‘shiladi', () {
    final event = Event(
      title: 'O‘g‘lim tug‘ilgan kuni',
      dateTime: DateTime(2020, 6, 13, 11, 0),
      description: '',
      category: EventCategory.birthday,
    );

    const elapsed = ElapsedTime(
      years: 6,
      months: 3,
      days: 14,
      hours: 9,
      minutes: 15,
      seconds: 32,
    );

    const insights = BirthdayInsights(
      heartbeats: 231574853,
      breaths: 49622469,
      earthRotations: 2297,
      orbitalDistanceKm: 6849000000,
    );

    final result = EventShareService.buildShareText(
      event: event,
      elapsed: elapsed,
      l10n: l10n,
      birthdayInsights: insights,
    );

    expect(result, contains('Qiziqarli statistika'));
    expect(result, contains('231 574 853'));
    expect(result, contains('49 622 469'));
    expect(result, contains('2 297'));
    expect(result, contains('6 849 000 000'));
  });

  test('description bo‘lsa share matniga qo‘shiladi', () {
    final event = Event(
      title: 'Oilaviy voqea',
      dateTime: DateTime(2025, 1, 10, 8, 0),
      description: 'Bizning oilamiz uchun muhim kun',
    );

    const elapsed = ElapsedTime(
      years: 1,
      months: 0,
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
    );

    final result = EventShareService.buildShareText(
      event: event,
      elapsed: elapsed,
      l10n: l10n,
    );

    expect(result, contains('Izoh:'));
    expect(result, contains('Bizning oilamiz uchun muhim kun'));
  });

  test('birthday bo‘lmagan eventga birthday statistikasi qo‘shilmaydi', () {
    final event = Event(
      title: 'Oddiy event',
      dateTime: DateTime(2025, 1, 1),
      description: '',
      category: EventCategory.general,
    );

    const elapsed = ElapsedTime(
      years: 1,
      months: 0,
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
    );

    const insights = BirthdayInsights(
      heartbeats: 100,
      breaths: 50,
      earthRotations: 10,
      orbitalDistanceKm: 1000,
    );

    final result = EventShareService.buildShareText(
      event: event,
      elapsed: elapsed,
      l10n: l10n,
      birthdayInsights: insights,
    );

    expect(result, isNot(contains('Qiziqarli statistika')));
    expect(result, isNot(contains('100')));
  });
}
