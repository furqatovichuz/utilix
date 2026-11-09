// Ikonka PNG fayllarini LogoPainter'dan yaratadi:
//   flutter test test_tool/gen_icon_test.dart
// So'ng:
//   dart run flutter_launcher_icons
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toolbox/core/logo.dart';

Future<void> _render(WidgetTester tester, String path, LogoPainter painter, {int size = 1024}) async {
  await tester.runAsync(() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    painter.paint(canvas, Size.square(size.toDouble()));
    final image = await recorder.endRecording().toImage(size, size);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    await File(path).writeAsBytes(data!.buffer.asUint8List());
  });
}

void main() {
  testWidgets('generate launcher icons', (tester) async {
    // Eski iOS/Android: to'liq kvadrat, gradient fon + belgi.
    await _render(tester, 'assets/icon/icon.png', const LogoPainter(rounded: false, glyphScale: .56));
    // Adaptiv ikonka: faqat belgi (xavfsiz zona ichida, shaffof fon).
    await _render(tester, 'assets/icon/icon_fg.png', const LogoPainter(background: false, glyphScale: .42));
    // Adaptiv ikonka foni: faqat gradient.
    await _render(tester, 'assets/icon/icon_bg.png', const LogoPainter(rounded: false, glyphScale: 0));
    // Play Market 512×512 katalog ikonkasi.
    await _render(tester, 'assets/icon/store_512.png', const LogoPainter(rounded: false, glyphScale: .56), size: 512);
  });
}
