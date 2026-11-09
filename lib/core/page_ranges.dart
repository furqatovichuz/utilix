/// "1-3, 5, 8-10" ko'rinishidagi matnni 0 dan boshlanadigan sahifa indekslariga aylantiradi.
///
/// Tartib va takrorlanish saqlanadi (masalan "3,1" → [2, 0]).
/// Noto'g'ri format yoki [total] dan chiqib ketgan sahifada `null` qaytaradi.
List<int>? parsePageRanges(String input, int total) {
  final text = input.replaceAll(RegExp(r'\s'), '');
  if (text.isEmpty || total < 1) return null;

  final result = <int>[];
  for (final part in text.split(',')) {
    if (part.isEmpty) return null;
    final bounds = part.split('-');
    if (bounds.length > 2) return null;

    final from = int.tryParse(bounds.first);
    final to = bounds.length == 2 ? int.tryParse(bounds.last) : from;
    if (from == null || to == null) return null;
    if (from < 1 || to < from || to > total) return null;

    for (var p = from; p <= to; p++) {
      result.add(p - 1);
    }
  }
  return result;
}
