/// Sonni so'z bilan yozish: en, ru, uz, kk, ky, tk, tr.
///
/// 999 trilliongacha (15 xonali sondan kichik) sonlar qo'llab-quvvatlanadi.
library;

const maxNumberWords = 999999999999999;

String numberToWords(int n, String lang) {
  assert(n.abs() <= maxNumberWords);
  return switch (lang) {
    'ru' => _russian(n),
    'en' => _english(n),
    _ => _turkic(n, _turkicData[lang] ?? _turkicData['uz']!),
  };
}

// ───────────────────────── Turkiy tillar ─────────────────────────

class _Turkic {
  const _Turkic({
    required this.zero,
    required this.minus,
    required this.ones,
    required this.tens,
    required this.hundred,
    required this.scales,
  });

  final String zero;
  final String minus;

  /// Indeks 1..9 ishlatiladi (0-indeks bo'sh).
  final List<String> ones;
  final List<String> tens;
  final String hundred;

  /// ['', ming, million, milliard, trillion]
  final List<String> scales;
}

const _turkicData = <String, _Turkic>{
  'uz': _Turkic(
    zero: 'nol',
    minus: 'minus',
    ones: ['', 'bir', 'ikki', 'uch', 'to\'rt', 'besh', 'olti', 'yetti', 'sakkiz', 'to\'qqiz'],
    tens: ['', 'o\'n', 'yigirma', 'o\'ttiz', 'qirq', 'ellik', 'oltmish', 'yetmish', 'sakson', 'to\'qson'],
    hundred: 'yuz',
    scales: ['', 'ming', 'million', 'milliard', 'trillion'],
  ),
  'kk': _Turkic(
    zero: 'нөл',
    minus: 'минус',
    ones: ['', 'бір', 'екі', 'үш', 'төрт', 'бес', 'алты', 'жеті', 'сегіз', 'тоғыз'],
    tens: ['', 'он', 'жиырма', 'отыз', 'қырық', 'елу', 'алпыс', 'жетпіс', 'сексен', 'тоқсан'],
    hundred: 'жүз',
    scales: ['', 'мың', 'миллион', 'миллиард', 'триллион'],
  ),
  'ky': _Turkic(
    zero: 'нөл',
    minus: 'минус',
    ones: ['', 'бир', 'эки', 'үч', 'төрт', 'беш', 'алты', 'жети', 'сегиз', 'тогуз'],
    tens: ['', 'он', 'жыйырма', 'отуз', 'кырк', 'элүү', 'алтымыш', 'жетимиш', 'сексен', 'токсон'],
    hundred: 'жүз',
    scales: ['', 'миң', 'миллион', 'миллиард', 'триллион'],
  ),
  'tk': _Turkic(
    zero: 'nol',
    minus: 'minus',
    ones: ['', 'bir', 'iki', 'üç', 'dört', 'bäş', 'alty', 'ýedi', 'sekiz', 'dokuz'],
    tens: ['', 'on', 'ýigrimi', 'otuz', 'kyrk', 'elli', 'altmyş', 'ýetmiş', 'segsen', 'togsan'],
    hundred: 'ýüz',
    scales: ['', 'müň', 'million', 'milliard', 'trillion'],
  ),
  'tr': _Turkic(
    zero: 'sıfır',
    minus: 'eksi',
    ones: ['', 'bir', 'iki', 'üç', 'dört', 'beş', 'altı', 'yedi', 'sekiz', 'dokuz'],
    tens: ['', 'on', 'yirmi', 'otuz', 'kırk', 'elli', 'altmış', 'yetmiş', 'seksen', 'doksan'],
    hundred: 'yüz',
    scales: ['', 'bin', 'milyon', 'milyar', 'trilyon'],
  ),
};

String _turkic(int n, _Turkic d) {
  if (n == 0) return d.zero;
  var rest = n.abs();
  final parts = <String>[];
  var scale = 0;
  while (rest > 0) {
    final chunk = rest % 1000;
    if (chunk != 0) {
      final words = <String>[];
      final h = chunk ~/ 100;
      // "yuz", "ming" oldidagi "bir" tushiriladi: 100 → yuz, 1000 → ming.
      if (h > 0) words.addAll([if (h > 1) d.ones[h], d.hundred]);
      final t = (chunk % 100) ~/ 10;
      final o = chunk % 10;
      if (t > 0) words.add(d.tens[t]);
      if (o > 0 && !(scale == 1 && chunk == 1)) words.add(d.ones[o]);
      if (scale > 0) words.add(d.scales[scale]);
      parts.insert(0, words.join(' '));
    }
    rest ~/= 1000;
    scale++;
  }
  return '${n < 0 ? '${d.minus} ' : ''}${parts.join(' ')}';
}

// ───────────────────────── Ingliz tili ─────────────────────────

const _enOnes = [
  '', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',
  'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen',
  'eighteen', 'nineteen',
];
const _enTens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
const _enScales = ['', 'thousand', 'million', 'billion', 'trillion'];

String _english(int n) {
  if (n == 0) return 'zero';
  var rest = n.abs();
  final parts = <String>[];
  var scale = 0;
  while (rest > 0) {
    final chunk = rest % 1000;
    if (chunk != 0) {
      final words = <String>[];
      if (chunk >= 100) words.add('${_enOnes[chunk ~/ 100]} hundred');
      final low = chunk % 100;
      if (low >= 20) {
        final unit = low % 10;
        words.add(unit == 0 ? _enTens[low ~/ 10] : '${_enTens[low ~/ 10]}-${_enOnes[unit]}');
      } else if (low > 0) {
        words.add(_enOnes[low]);
      }
      if (scale > 0) words.add(_enScales[scale]);
      parts.insert(0, words.join(' '));
    }
    rest ~/= 1000;
    scale++;
  }
  return '${n < 0 ? 'minus ' : ''}${parts.join(' ')}';
}

// ───────────────────────── Rus tili ─────────────────────────

const _ruOnes = ['', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять'];
const _ruOnesFem = ['', 'одна', 'две', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять'];
const _ruTeens = [
  'десять', 'одиннадцать', 'двенадцать', 'тринадцать', 'четырнадцать', 'пятнадцать',
  'шестнадцать', 'семнадцать', 'восемнадцать', 'девятнадцать',
];
const _ruTens = [
  '', '', 'двадцать', 'тридцать', 'сорок', 'пятьдесят', 'шестьдесят', 'семьдесят',
  'восемьдесят', 'девяносто',
];
const _ruHundreds = [
  '', 'сто', 'двести', 'триста', 'четыреста', 'пятьсот', 'шестьсот', 'семьсот',
  'восемьсот', 'девятьсот',
];

/// [ед. (1), 2–4, 5+] shakllari.
const _ruScales = <List<String>>[
  [],
  ['тысяча', 'тысячи', 'тысяч'],
  ['миллион', 'миллиона', 'миллионов'],
  ['миллиард', 'миллиарда', 'миллиардов'],
  ['триллион', 'триллиона', 'триллионов'],
];

String _ruPlural(int n, List<String> forms) {
  final mod100 = n % 100;
  final mod10 = n % 10;
  if (mod100 >= 11 && mod100 <= 14) return forms[2];
  if (mod10 == 1) return forms[0];
  if (mod10 >= 2 && mod10 <= 4) return forms[1];
  return forms[2];
}

String _russian(int n) {
  if (n == 0) return 'ноль';
  var rest = n.abs();
  final parts = <String>[];
  var scale = 0;
  while (rest > 0) {
    final chunk = rest % 1000;
    if (chunk != 0) {
      final words = <String>[];
      if (chunk >= 100) words.add(_ruHundreds[chunk ~/ 100]);
      final low = chunk % 100;
      // Ming (scale 1) ayol jinsida: "одна тысяча", "две тысячи".
      final ones = scale == 1 ? _ruOnesFem : _ruOnes;
      if (low >= 20) {
        words.add(_ruTens[low ~/ 10]);
        if (low % 10 > 0) words.add(ones[low % 10]);
      } else if (low >= 10) {
        words.add(_ruTeens[low - 10]);
      } else if (low > 0) {
        words.add(ones[low]);
      }
      if (scale > 0) words.add(_ruPlural(chunk, _ruScales[scale]));
      parts.insert(0, words.join(' '));
    }
    rest ~/= 1000;
    scale++;
  }
  return '${n < 0 ? 'минус ' : ''}${parts.join(' ')}';
}
