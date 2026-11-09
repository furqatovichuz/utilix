import 'package:flutter_test/flutter_test.dart';
import 'package:toolbox/core/page_ranges.dart';

void main() {
  test('parses ranges and single pages', () {
    expect(parsePageRanges('1-3, 5, 8-9', 10), [0, 1, 2, 4, 7, 8]);
  });

  test('keeps order and duplicates', () {
    expect(parsePageRanges('3,1', 5), [2, 0]);
  });

  test('rejects invalid input', () {
    expect(parsePageRanges('', 5), isNull);
    expect(parsePageRanges('0', 5), isNull);
    expect(parsePageRanges('6', 5), isNull);
    expect(parsePageRanges('3-1', 5), isNull);
    expect(parsePageRanges('1--3', 5), isNull);
    expect(parsePageRanges('1,,2', 5), isNull);
    expect(parsePageRanges('a', 5), isNull);
  });
}
