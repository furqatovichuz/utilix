import 'dart:typed_data';

import 'package:pdf_manipulator/pdf_manipulator.dart';

/// PDF'larni berilgan tartibda bittaga birlashtiradi.
Future<Uint8List> mergePdfs(Pdf pdf, List<Uint8List> documents) async {
  final sink = MemorySink();
  await pdf.merge([for (final d in documents) MemorySource(d)], sink);
  return sink.takeBytes();
}
