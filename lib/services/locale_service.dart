import 'package:shared_preferences/shared_preferences.dart';

class LocaleService {
  static const String _localeKey = 'app_locale';

  Future<String?> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_localeKey);
  }

  Future<void> saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_localeKey, languageCode);
  }
}
