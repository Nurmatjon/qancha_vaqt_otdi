import 'package:flutter_test/flutter_test.dart';

import 'package:qancha_vaqt_otdi/models/birthday_insights.dart';
import 'package:qancha_vaqt_otdi/services/birthday_insights_service.dart';

void main() {
  test('1 daqiqalik vaqt uchun yurak urishi va nafaslar hisoblanadi', () {
    final birthDate = DateTime.now().subtract(
      const Duration(minutes: 1),
    );

    final result = BirthdayInsightsService.calculate(birthDate);

    expect(result, isA<BirthdayInsights>());

    expect(result.heartbeats, inInclusiveRange(70, 71));
    expect(result.breaths, inInclusiveRange(15, 16));

    expect(result.earthRotations, 0);

    expect(
      result.orbitalDistanceKm,
      greaterThanOrEqualTo(1786.8),
    );

    expect(
      result.orbitalDistanceKm,
      lessThan(1820),
    );

    expect(
      result.moonDistanceEquivalent,
      greaterThan(0),
    );
  });

  test('Kelajakdagi tug‘ilgan sana uchun barcha qiymatlar 0 bo‘ladi', () {
    final futureDate = DateTime.now().add(
      const Duration(days: 1),
    );

    final result = BirthdayInsightsService.calculate(futureDate);

    expect(result.heartbeats, 0);
    expect(result.breaths, 0);
    expect(result.earthRotations, 0);
    expect(result.orbitalDistanceKm, 0);
    expect(result.moonDistanceEquivalent, 0);
  });

  test('1 sutka uchun Yer aylanishi 1 ga teng bo‘ladi', () {
    final birthDate = DateTime.now().subtract(
      const Duration(days: 1),
    );

    final result = BirthdayInsightsService.calculate(birthDate);

    expect(result.earthRotations, closeTo(1, 0.001));
  });

  test('0 vaqt uchun barcha qiymatlar 0 bo‘ladi', () {
    final now = DateTime.now();

    final result = BirthdayInsightsService.calculate(now);

    expect(result.heartbeats, 0);
    expect(result.breaths, 0);
    expect(result.earthRotations, 0);
    expect(result.orbitalDistanceKm, 0);
    expect(result.moonDistanceEquivalent, 0);
  });
}