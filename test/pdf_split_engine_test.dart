import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:toolbox/core/pdf_ops.dart';

/// Haqiqiy PDF dvigateli bilan ishlaydigan testlar.
Future<Uint8List> _makePdf(int pages) async {
  final doc = pw.Document();
  for (var i = 1; i <= pages; i++) {
    doc.addPage(pw.Page(build: (_) => pw.Center(child: pw.Text('Page $i'))));
  }
  return doc.save();
}

Future<int> _pageCount(Pdf pdf, Uint8List bytes) async {
  final doc = await pdf.open(MemorySource(bytes));
  final n = doc.pageCount;
  await doc.dispose();
  return n;
}

void main() {
  late Pdf pdf;
  setUp(() => pdf = Pdf());
  tearDown(() => pdf.dispose());

  test('extractPages keeps only the requested pages', () async {
    final sink = MemorySink();
    await pdf.extractPages(MemorySource(await _makePdf(5)), sink, pages: [0, 2, 4]);
    expect(await _pageCount(pdf, sink.takeBytes()), 3);
  });

  test('mergePdfs combines all pages in order', () async {
    final merged = await mergePdfs(pdf, [await _makePdf(2), await _makePdf(3), await _makePdf(1)]);
    expect(await _pageCount(pdf, merged), 6);
  });

  test('mergePdfs rejects broken input', () async {
    final good = await _makePdf(1);
    expect(
      () => mergePdfs(pdf, [Uint8List.fromList([1, 2, 3]), good]),
      throwsA(anything),
    );
  });
}
