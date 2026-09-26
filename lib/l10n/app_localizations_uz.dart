// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'Qancha vaqt o‘tdi?';

  @override
  String get noEvents => 'Hali hech qanday voqea qo‘shilmagan';

  @override
  String get edit => 'Tahrirlash';

  @override
  String get delete => 'O‘chirish';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get deleteEventTitle => 'Voqeani o‘chirish';

  @override
  String deleteEventMessage(Object title) {
    return '“$title” voqeasini o‘chirishni xohlaysizmi?';
  }

  @override
  String years(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yil',
      one: '$count yil',
    );
    return '$_temp0';
  }

  @override
  String months(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oy',
      one: '$count oy',
    );
    return '$_temp0';
  }

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kun',
      one: '$count kun',
    );
    return '$_temp0';
  }

  @override
  String get interestingStatistics => 'Qiziqarli statistika';

  @override
  String get startDate => 'Boshlangan sana';

  @override
  String get description => 'Izoh';

  @override
  String heartbeats(Object count) {
    return '≈ $count marta yurak urgan';
  }

  @override
  String breaths(Object count) {
    return '≈ $count marta nafas olindi';
  }

  @override
  String earthRotations(Object count) {
    return '≈ $count marta Yer o‘z o‘qi atrofida aylandi';
  }

  @override
  String orbitalDistance(Object count) {
    return '≈ $count km masofani Yer bilan birga bosib o‘tildi';
  }

  @override
  String get editEventTitle => 'Voqeani tahrirlash';

  @override
  String get newEventTitle => 'Yangi voqea';

  @override
  String get eventName => 'Voqea nomi';

  @override
  String get eventNameHint => 'Masalan: O‘g‘lim tug‘ilgan kun';

  @override
  String get category => 'Kategoriya';

  @override
  String get generalEvent => 'Oddiy voqea';

  @override
  String get birthday => 'Tug‘ilgan kun';

  @override
  String get shortDescription => 'Qisqa izoh';

  @override
  String get shortDescriptionHint => 'Masalan: Oilamizga yangi quvonch keldi';

  @override
  String get save => 'Saqlash';
}
