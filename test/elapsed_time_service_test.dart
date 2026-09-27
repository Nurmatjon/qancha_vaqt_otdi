import 'package:flutter_test/flutter_test.dart';

import '../lib/services/elapsed_time_service.dart';

void main() {
  group('ElapsedTimeService', () {
    test('bir yilni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2020, 1, 15, 10, 30, 0);
      final end = DateTime(2021, 1, 15, 10, 30, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 1);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test(
      'boshlanish va tugash vaqti bir xil bo‘lsa barcha qiymatlar 0 bo‘ladi',
      () {
        final start = DateTime(2025, 6, 15, 14, 30, 45);
        final end = start;

        final result = ElapsedTimeService.calculate(start, end);

        expect(result.years, 0);
        expect(result.months, 0);
        expect(result.days, 0);
        expect(result.hours, 0);
        expect(result.minutes, 0);
        expect(result.seconds, 0);
      },
    );

    test('bir oy va bir kunni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 1, 10, 12, 0, 0);
      final end = DateTime(2025, 2, 11, 12, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 1);
      expect(result.days, 1);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test('soat, minut va sekundni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 1, 1, 10, 0, 0);
      final end = DateTime(2025, 1, 1, 12, 35, 42);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 2);
      expect(result.minutes, 35);
      expect(result.seconds, 42);
    });

    test('boshlanish vaqti kelajakda bo‘lsa nol qaytaradi', () {
      final start = DateTime(2025, 1, 2, 10, 0, 0);
      final end = DateTime(2025, 1, 1, 10, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test('kabisa yilidagi 29-fevralni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2020, 2, 29, 10, 0, 0);
      final end = DateTime(2021, 2, 28, 10, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 1);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test('31-yanvardan 28-fevralgacha bo‘lgan davrni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 1, 31, 10, 0, 0);
      final end = DateTime(2025, 2, 28, 10, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 1);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test('aniq bir sekundni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 1, 1, 10, 0, 0);
      final end = DateTime(2025, 1, 1, 10, 0, 1);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 1);
    });

    test('oy chegarasida vaqtni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 1, 31, 23, 59, 59);
      final end = DateTime(2025, 2, 1, 0, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 1);
    });

    test('yil chegarasida vaqtni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2024, 12, 31, 23, 59, 59);
      final end = DateTime(2025, 1, 1, 0, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 1);
    });

    test('29-fevraldan keyingi yilga o‘tishni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2020, 2, 29, 10, 0, 0);
      final end = DateTime(2024, 2, 29, 10, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 4);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test('31-martdan 30-aprelgacha bo‘lgan davrni to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 3, 31, 10, 0, 0);
      final end = DateTime(2025, 4, 30, 10, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 1);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });

    test('oy chegarasida vaqt farqini to‘g‘ri hisoblaydi', () {
      final start = DateTime(2025, 1, 31, 23, 59, 58);
      final end = DateTime(2025, 2, 1, 0, 0, 1);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 3);
    });

    test('29-fevraldan keyingi oddiy yil sanasini hisoblaydi', () {
      final start = DateTime(2020, 2, 29, 10, 0, 0);
      final end = DateTime(2021, 2, 27, 10, 0, 0);

      final result = ElapsedTimeService.calculate(start, end);

      expect(result.years, 0);
      expect(result.months, 11);
      expect(result.days, 29);
      expect(result.hours, 0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });
  });
}
