import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolbox/app.dart';
import 'package:toolbox/core/l10n.dart';
import 'package:toolbox/core/registry.dart';
import 'package:toolbox/core/store.dart';
import 'package:toolbox/core/tool.dart';

Future<AppStore> _store([String? locale]) async {
  SharedPreferences.setMockInitialValues({'locale': ?locale});
  return AppStore.load();
}

void main() {
  testWidgets('first launch asks for a language, then shows the home screen', (tester) async {
    final store = await _store();
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(UtilixApp(store: store));
    await tester.pumpAndSettle();

    // Hamma 7 til ko'rinadi.
    for (final lang in appLanguages) {
      expect(find.text(lang.nativeName), findsOneWidget, reason: lang.code);
    }
    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.text('Русский'));
    await tester.pumpAndSettle();

    expect(store.locale, const Locale('ru'));
    expect(find.text('Все инструменты'), findsOneWidget);
  });

  testWidgets('saved language skips the picker', (tester) async {
    final store = await _store('tr');
    await tester.pumpWidget(UtilixApp(store: store));
    await tester.pumpAndSettle();
    expect(find.text('Tüm araçlar'), findsOneWidget);
  });

  testWidgets('language can be changed from the home screen', (tester) async {
    final store = await _store('en');
    await tester.pumpWidget(UtilixApp(store: store));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Қазақша'));
    await tester.pumpAndSettle();

    expect(find.text('Барлық құралдар'), findsOneWidget);
  });

  for (final lang in appLanguages) {
    testWidgets('every tool opens without errors in ${lang.code}', (tester) async {
      final store = await _store(lang.code);
      final l = lookupAppLocalizations(lang.locale);
      await tester.binding.setSurfaceSize(const Size(420, 5000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final tool in allTools) {
        await tester.pumpWidget(UtilixApp(store: store));
        await tester.pumpAndSettle();
        await tester.tap(find.text(tool.category.label(l)).first);
        await tester.pumpAndSettle();
        await tester.tap(find.text(tool.name(l)).first);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '${lang.code}: ${tool.id}');
        final nav = tester.state<NavigatorState>(find.byType(Navigator));
        nav.pop();
        await tester.pumpAndSettle();
        nav.pop();
        await tester.pumpAndSettle();
      }
    });
  }

  testWidgets('home shows one card per section and opens it', (tester) async {
    final store = await _store('en');
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(UtilixApp(store: store));
    await tester.pumpAndSettle();
    expect(ToolCategory.values.length, inInclusiveRange(5, 6));
    final l = lookupAppLocalizations(const Locale('en'));
    for (final c in ToolCategory.values) {
      expect(find.text(c.label(l)), findsOneWidget, reason: c.name);
    }
    await tester.tap(find.text('PDF & images'));
    await tester.pumpAndSettle();
    expect(find.text('Merge PDF'), findsOneWidget);
  });

  testWidgets('search works across names and keywords', (tester) async {
    final store = await _store('en');
    await tester.pumpWidget(UtilixApp(store: store));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'password');
    await tester.pumpAndSettle();
    expect(find.text('Password generator'), findsOneWidget);
    expect(find.text('Calculator'), findsNothing);
  });
}
