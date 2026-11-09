import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n.dart';

/// Tema, til, sevimlilar va oxirgi ishlatilgan asboblar holati.
class AppStore extends ChangeNotifier {
  AppStore._(this._prefs)
      : _favorites = (_prefs.getStringList('favorites') ?? []).toSet(),
        _recent = _prefs.getStringList('recent') ?? [],
        _locale = _readLocale(_prefs),
        _themeMode = ThemeMode.values[
            (_prefs.getInt('theme') ?? 0).clamp(0, ThemeMode.values.length - 1)];

  final SharedPreferences _prefs;
  final Set<String> _favorites;
  final List<String> _recent;
  ThemeMode _themeMode;
  Locale? _locale;

  static Locale? _readLocale(SharedPreferences prefs) {
    final code = prefs.getString('locale');
    final known = appLanguages.any((l) => l.code == code);
    return known ? Locale(code!) : null;
  }

  static Future<AppStore> load() async =>
      AppStore._(await SharedPreferences.getInstance());

  ThemeMode get themeMode => _themeMode;
  Set<String> get favorites => _favorites;
  List<String> get recent => List.unmodifiable(_recent);

  /// `null` — foydalanuvchi hali til tanlamagan (birinchi ishga tushirish).
  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    _prefs.setString('locale', locale.languageCode);
    notifyListeners();
  }

  bool isFavorite(String id) => _favorites.contains(id);

  void toggleFavorite(String id) {
    if (!_favorites.remove(id)) _favorites.add(id);
    _prefs.setStringList('favorites', _favorites.toList());
    notifyListeners();
  }

  void markUsed(String id) {
    _recent
      ..remove(id)
      ..insert(0, id);
    if (_recent.length > 6) _recent.removeRange(6, _recent.length);
    _prefs.setStringList('recent', _recent);
    notifyListeners();
  }

  void cycleTheme() {
    _themeMode = ThemeMode.values[(_themeMode.index + 1) % 3];
    _prefs.setInt('theme', _themeMode.index);
    notifyListeners();
  }
}

class StoreScope extends InheritedNotifier<AppStore> {
  const StoreScope({super.key, required AppStore store, required super.child})
      : super(notifier: store);

  static AppStore of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoreScope>()!.notifier!;
}
