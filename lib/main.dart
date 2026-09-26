import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'services/locale_service.dart';

void main() {
  runApp(const QanchaVaqtOtdiApp());
}

class QanchaVaqtOtdiApp extends StatefulWidget {
  const QanchaVaqtOtdiApp({super.key});

  @override
  State<QanchaVaqtOtdiApp> createState() => _QanchaVaqtOtdiAppState();
}

class _QanchaVaqtOtdiAppState extends State<QanchaVaqtOtdiApp> {
  final LocaleService _localeService = LocaleService();

  Locale? _locale;

  @override
  void initState() {
    super.initState();

    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final languageCode = await _localeService.loadLocale();

    if (!mounted) return;

    if (languageCode != null) {
      setState(() {
        _locale = Locale(languageCode);
      });
    }
  }

  Future<void> _changeLocale(String languageCode) async {
    await _localeService.saveLocale(languageCode);

    if (!mounted) return;

    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: _locale,

      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.appTitle;
      },

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),

      home: HomeScreen(onLocaleChanged: _changeLocale),
    );
  }
}
