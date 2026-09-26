class ElapsedTime {
  final int years;
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const ElapsedTime({
    required this.years,
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

class ElapsedTimeService {
  static ElapsedTime calculate(DateTime start, DateTime end) {
    if (end.isBefore(start)) {
      return const ElapsedTime(
        years: 0,
        months: 0,
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
      );
    }

    int years = end.year - start.year;
    DateTime cursor = _addYears(start, years);

    if (cursor.isAfter(end)) {
      years--;
      cursor = _addYears(start, years);
    }

    int months =
      (end.year - cursor.year) * 12 +
      (end.month - cursor.month);

    DateTime monthCursor = _addMonths(cursor, months);

    if (monthCursor.isAfter(end)) {
      months--;
      monthCursor = _addMonths(cursor, months);
    }

    final difference = end.difference(monthCursor);

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return ElapsedTime(
      years: years,
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  static DateTime _addYears(DateTime date, int years) {
    final targetYear = date.year + years;
    final maxDay = _daysInMonth(targetYear, date.month);
    final targetDay =
      date.month == 2 && date.day == 29 && maxDay == 28
          ? 28
          : date.day > maxDay
              ? maxDay
              : date.day;

    return DateTime(
      targetYear,
      date.month,
      targetDay,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  static DateTime _addMonths(DateTime date, int months) {
    final totalMonths = date.year * 12 + (date.month - 1) + months;
    final targetYear = totalMonths ~/ 12;
    final targetMonth = totalMonths % 12 + 1;
    final maxDay = _daysInMonth(targetYear, targetMonth);

    return DateTime(
      targetYear,
      targetMonth,
      date.day > maxDay ? maxDay : date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  static int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}