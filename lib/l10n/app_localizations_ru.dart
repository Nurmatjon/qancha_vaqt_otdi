// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Сколько времени прошло?';

  @override
  String get noEvents => 'Пока не добавлено ни одного события';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get deleteEventTitle => 'Удалить событие';

  @override
  String deleteEventMessage(Object title) {
    return 'Удалить событие «$title»?';
  }

  @override
  String years(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count года',
      many: '$count лет',
      few: '$count года',
      one: '$count год',
    );
    return '$_temp0';
  }

  @override
  String months(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count месяца',
      many: '$count месяцев',
      few: '$count месяца',
      one: '$count месяц',
    );
    return '$_temp0';
  }

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get interestingStatistics => 'Интересная статистика';

  @override
  String get startDate => 'Дата начала';

  @override
  String get description => 'Описание';

  @override
  String heartbeats(Object count) {
    return '≈ $count ударов сердца';
  }

  @override
  String breaths(Object count) {
    return '≈ $count вдохов';
  }

  @override
  String earthRotations(Object count) {
    return '≈ $count оборотов Земли вокруг своей оси';
  }

  @override
  String orbitalDistance(Object count) {
    return '≈ $count км пройдено вместе с Землёй вокруг Солнца';
  }

  @override
  String get editEventTitle => 'Редактирование события';

  @override
  String get newEventTitle => 'Новое событие';

  @override
  String get eventName => 'Название события';

  @override
  String get eventNameHint => 'Например: День рождения моего сына';

  @override
  String get category => 'Категория';

  @override
  String get generalEvent => 'Обычное событие';

  @override
  String get birthday => 'День рождения';

  @override
  String get shortDescription => 'Краткое описание';

  @override
  String get shortDescriptionHint => 'Например: В нашей семье появилась новая радость';

  @override
  String get save => 'Сохранить';
}
