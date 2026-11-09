import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:toolbox/core/image_ops.dart';

void main() {
  late Uint8List source;

  setUp(() {
    final im = img.Image(width: 400, height: 200);
    img.fill(im, color: img.ColorRgb8(200, 30, 90));
    source = Uint8List.fromList(img.encodePng(im));
  });

  test('resizes by longest side keeping aspect ratio', () async {
    final r = await processImage(ImageJob(bytes: source, maxSide: 100));
    expect((r.width, r.height), (100, 50));
  });

  test('rotation swaps sides', () async {
    final r = await processImage(ImageJob(bytes: source, rotate: 90));
    expect((r.width, r.height), (200, 400));
  });

  test('jpeg output is smaller at lower quality and decodes', () async {
    final high = await processImage(ImageJob(bytes: source, quality: 95));
    final low = await processImage(ImageJob(bytes: source, quality: 20));
    expect(low.bytes.length, lessThanOrEqualTo(high.bytes.length));
    expect(img.decodeJpg(low.bytes), isNotNull);
  });

  test('png output decodes', () async {
    final r = await processImage(ImageJob(bytes: source, png: true));
    expect(img.decodePng(r.bytes), isNotNull);
  });

  test('invalid data throws', () async {
    expect(
      () => processImage(ImageJob(bytes: Uint8List.fromList([1, 2, 3]))),
      throwsA(anything),
    );
  });
}
