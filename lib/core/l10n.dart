import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/app_localizations.dart';

export '../l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

class AppLanguage {
  const AppLanguage(this.code, this.nativeName);
  final String code;
  final String nativeName;

  Locale get locale => Locale(code);
}

/// Til tanlash ro'yxati. Nomlar o'z tilida yoziladi.
const appLanguages = [
  AppLanguage('en', 'English'),
  AppLanguage('ru', 'Русский'),
  AppLanguage('uz', 'O\'zbekcha'),
  AppLanguage('kk', 'Қазақша'),
  AppLanguage('ky', 'Кыргызча'),
  AppLanguage('tk', 'Türkmençe'),
  AppLanguage('tr', 'Türkçe'),
];

/// Flutter'ning standart vidjetlari (sana tanlagich, "Orqaga" kabi matnlar)
/// turkman tilini bilmaydi. Shu til uchun eng yaqin tilni (turk) beramiz.
class _TurkmenFallback<T> extends LocalizationsDelegate<T> {
  const _TurkmenFallback(this.base);
  final LocalizationsDelegate<T> base;

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tk';

  @override
  Future<T> load(Locale locale) => base.load(const Locale('tr'));

  @override
  bool shouldReload(covariant LocalizationsDelegate<T> old) => false;
}

const List<LocalizationsDelegate<dynamic>> appLocalizationDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  _TurkmenFallback<MaterialLocalizations>(GlobalMaterialLocalizations.delegate),
  _TurkmenFallback<WidgetsLocalizations>(GlobalWidgetsLocalizations.delegate),
  _TurkmenFallback<CupertinoLocalizations>(GlobalCupertinoLocalizations.delegate),
];
