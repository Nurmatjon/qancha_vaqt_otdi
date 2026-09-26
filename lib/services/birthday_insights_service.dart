import '../models/birthday_insights.dart';

class BirthdayInsightsService {
  static const double heartbeatsPerMinute = 70;
  static const double breathsPerMinute = 15;
  static const double earthOrbitalSpeedKmPerSecond = 29.78;
  static const double earthMoonDistanceKm = 384400;

  static BirthdayInsights calculate(DateTime birthDate) {
    final now = DateTime.now();

    if (birthDate.isAfter(now)) {
      return const BirthdayInsights(
        heartbeats: 0,
        breaths: 0,
        earthRotations: 0,
        orbitalDistanceKm: 0,
        moonDistanceEquivalent: 0,
      );
    }

    final duration = now.difference(birthDate);

    final totalSeconds = duration.inSeconds;
    final totalMinutes = totalSeconds / 60;
    final totalDays = duration.inHours / 24;

    final heartbeats =
    (totalMinutes * heartbeatsPerMinute).round();

    final breaths =
        (totalMinutes * breathsPerMinute).round();

    final earthRotations =
        totalDays;

    final orbitalDistanceKm =
        totalSeconds * earthOrbitalSpeedKmPerSecond;

    final moonDistanceEquivalent =
        orbitalDistanceKm / earthMoonDistanceKm;

    return BirthdayInsights(
      heartbeats: heartbeats,
      breaths: breaths,
      earthRotations: earthRotations,
      orbitalDistanceKm: orbitalDistanceKm,
      moonDistanceEquivalent: moonDistanceEquivalent,
    );
  }
}