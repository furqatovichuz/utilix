import 'package:flutter_test/flutter_test.dart';
import 'package:toolbox/core/number_words.dart';

void main() {
  test('uzbek', () {
    expect(numberToWords(0, 'uz'), 'nol');
    expect(numberToWords(15, 'uz'), 'o\'n besh');
    expect(numberToWords(100, 'uz'), 'yuz');
    expect(numberToWords(1000, 'uz'), 'ming');
    expect(numberToWords(1250300, 'uz'), 'bir million ikki yuz ellik ming uch yuz');
    expect(numberToWords(-7, 'uz'), 'minus yetti');
  });

  test('english', () {
    expect(numberToWords(0, 'en'), 'zero');
    expect(numberToWords(13, 'en'), 'thirteen');
    expect(numberToWords(21, 'en'), 'twenty-one');
    expect(numberToWords(1250300, 'en'), 'one million two hundred fifty thousand three hundred');
    expect(numberToWords(-5, 'en'), 'minus five');
  });

  test('russian agreement', () {
    expect(numberToWords(21000, 'ru'), 'двадцать одна тысяча');
    expect(numberToWords(2000, 'ru'), 'две тысячи');
    expect(numberToWords(5000, 'ru'), 'пять тысяч');
    expect(numberToWords(11000, 'ru'), 'одиннадцать тысяч');
    expect(numberToWords(1250300, 'ru'), 'один миллион двести пятьдесят тысяч триста');
    expect(numberToWords(2000001, 'ru'), 'два миллиона один');
  });

  test('turkish', () {
    expect(numberToWords(100, 'tr'), 'yüz');
    expect(numberToWords(1000, 'tr'), 'bin');
    expect(numberToWords(2024, 'tr'), 'iki bin yirmi dört');
    expect(numberToWords(1250300, 'tr'), 'bir milyon iki yüz elli bin üç yüz');
  });

  test('kazakh, kyrgyz, turkmen', () {
    expect(numberToWords(35, 'kk'), 'отыз бес');
    expect(numberToWords(2000, 'ky'), 'эки миң');
    expect(numberToWords(1999, 'tk'), 'müň dokuz ýüz togsan dokuz');
  });

  test('largest supported value does not throw', () {
    for (final lang in ['en', 'ru', 'uz', 'kk', 'ky', 'tk', 'tr']) {
      expect(numberToWords(maxNumberWords, lang), isNotEmpty);
    }
  });
}
