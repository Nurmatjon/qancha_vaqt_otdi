// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'How Much Time Has Passed?';

  @override
  String get noEvents => 'No events have been added yet';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteEventTitle => 'Delete event';

  @override
  String deleteEventMessage(Object title) {
    return 'Do you want to delete the event “$title”?';
  }

  @override
  String years(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String months(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get interestingStatistics => 'Interesting statistics';

  @override
  String get startDate => 'Start date';

  @override
  String get description => 'Description';

  @override
  String heartbeats(Object count) {
    return '≈ $count heartbeats';
  }

  @override
  String breaths(Object count) {
    return '≈ $count breaths';
  }

  @override
  String earthRotations(Object count) {
    return '≈ $count rotations of the Earth around its axis';
  }

  @override
  String orbitalDistance(Object count) {
    return '≈ $count km traveled with Earth around the Sun';
  }

  @override
  String get editEventTitle => 'Edit event';

  @override
  String get newEventTitle => 'New event';

  @override
  String get eventName => 'Event name';

  @override
  String get eventNameHint => 'Example: My son\'s birthday';

  @override
  String get category => 'Category';

  @override
  String get generalEvent => 'General event';

  @override
  String get birthday => 'Birthday';

  @override
  String get shortDescription => 'Short description';

  @override
  String get shortDescriptionHint => 'Example: A new joy came into our family';

  @override
  String get save => 'Save';

  @override
  String get share => 'Share';

  @override
  String get backup => 'Backup';

  @override
  String get exportBackup => 'Export backup';

  @override
  String get importBackup => 'Import backup';

  @override
  String get importBackupTitle => 'Import backup';

  @override
  String get importBackupQuestion => 'How do you want to import the backup?';

  @override
  String get addBackup => 'Add';

  @override
  String get replaceBackup => 'Replace';
}
