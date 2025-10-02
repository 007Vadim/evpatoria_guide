import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app.dart';
import 'onboarding/onboarding_screen.dart';
import 'services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = PreferencesService();
  final seen = await prefs.getOnboardingSeen();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ru'), Locale('en')],
      path: 'assets/lang',
      fallbackLocale: Locale('ru'),
      child: seen ? EvpatoriaApp() : OnboardingWrapper(),
    ),
  );
}

// Обертка для OnboardingScreen — чтобы Scaffold работал правильно
class OnboardingWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evpatoria Guide',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}