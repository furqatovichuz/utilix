import 'package:flutter/material.dart';

import 'core/l10n.dart';
import 'core/store.dart';
import 'home/home_page.dart';
import 'home/language_page.dart';

const _seed = Color(0xFF6C5CE7);

ThemeData _theme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: const AppBarTheme(centerTitle: false, scrolledUnderElevation: 0),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: .5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

class UtilixApp extends StatelessWidget {
  const UtilixApp({super.key, required this.store});

  final AppStore store;

  @override
  Widget build(BuildContext context) => StoreScope(
        store: store,
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) => MaterialApp(
            title: 'Utilix',
            debugShowCheckedModeBanner: false,
            themeMode: store.themeMode,
            theme: _theme(Brightness.light),
            darkTheme: _theme(Brightness.dark),
            locale: store.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: appLocalizationDelegates,
            // Til tanlanmaguncha tanlash ekrani ko'rsatiladi.
            home: store.locale == null ? const LanguagePage(firstRun: true) : const HomePage(),
          ),
        ),
      );
}
