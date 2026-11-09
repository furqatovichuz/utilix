import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/logo.dart';
import '../core/store.dart';

/// Til tanlash ekrani. Birinchi ishga tushirishda ilovaning o'zi ochiladi,
/// keyinchalik bosh sahifadagi tugma orqali ham chaqiriladi.
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key, this.firstRun = false});

  final bool firstRun;

  @override
  Widget build(BuildContext context) {
    final store = StoreScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final device = PlatformDispatcher.instance.locale.languageCode;
    final selected = store.locale?.languageCode ??
        (appLanguages.any((l) => l.code == device) ? device : 'en');

    return Scaffold(
      appBar: firstRun ? null : AppBar(title: Text(context.l10n.languageTooltip)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              children: [
                if (firstRun) ...[
                  const Center(child: UtilixLogo(size: 88)),
                  const SizedBox(height: 16),
                  Text(
                    'Utilix',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your language\nВыберите язык · Til tanlang',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: scheme.onSurfaceVariant, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                ],
                for (final lang in appLanguages)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: lang.code == selected
                          ? scheme.primaryContainer
                          : scheme.surfaceContainerLow,
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        title: Text(
                          lang.nativeName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        trailing: lang.code == selected
                            ? Icon(Icons.check_circle_rounded, color: scheme.primary)
                            : Text(lang.code.toUpperCase(),
                                style: TextStyle(color: scheme.outline)),
                        onTap: () {
                          store.setLocale(lang.locale);
                          if (!firstRun) Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
