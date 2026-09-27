import '../l10n/app_localizations.dart';
import '../models/birthday_insights.dart';
import '../models/event.dart';
import '../models/event_category.dart';
import '../models/elapsed_time.dart';

class EventShareService {
  static String buildShareText({
    required Event event,
    required ElapsedTime elapsed,
    required AppLocalizations l10n,
    BirthdayInsights? birthdayInsights,
  }) {
    final buffer = StringBuffer();

    buffer.writeln(event.title);
    buffer.writeln();

    buffer.writeln(l10n.years(elapsed.years));
    buffer.writeln(
      '${l10n.months(elapsed.months)}  '
      '${l10n.days(elapsed.days)}',
    );
    buffer.writeln(
      '${_twoDigits(elapsed.hours)}:'
      '${_twoDigits(elapsed.minutes)}:'
      '${_twoDigits(elapsed.seconds)}',
    );

    buffer.writeln();
    buffer.writeln(
      '${l10n.startDate}: '
      '${event.dateTime.day.toString().padLeft(2, '0')}.'
      '${event.dateTime.month.toString().padLeft(2, '0')}.'
      '${event.dateTime.year} '
      '${_twoDigits(event.dateTime.hour)}:'
      '${_twoDigits(event.dateTime.minute)}',
    );

    if (event.description.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('${l10n.description}:');
      buffer.writeln(event.description);
    }

    if (event.category == EventCategory.birthday && birthdayInsights != null) {
      buffer.writeln();
      buffer.writeln(l10n.interestingStatistics);
      buffer.writeln(
        l10n.heartbeats(_formatNumber(birthdayInsights.heartbeats)),
      );
      buffer.writeln(l10n.breaths(_formatNumber(birthdayInsights.breaths)));
      buffer.writeln(
        l10n.earthRotations(
          _formatNumber(birthdayInsights.earthRotations.round()),
        ),
      );
      buffer.writeln(
        l10n.orbitalDistance(
          _formatNumber(birthdayInsights.orbitalDistanceKm.round()),
        ),
      );
    }

    return buffer.toString().trim();
  }

  static String _twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  static String _formatNumber(int value) {
    final number = value.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < number.length; i++) {
      if (i > 0 && (number.length - i) % 3 == 0) {
        buffer.write(' ');
      }

      buffer.write(number[i]);
    }

    return buffer.toString();
  }
}
