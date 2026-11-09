import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Rasmni qayta ishlash parametrlari. Isolate'ga yuborilgani uchun faqat oddiy qiymatlar.
class ImageJob {
  const ImageJob({
    required this.bytes,
    this.maxSide = 0,
    this.quality = 85,
    this.png = false,
    this.rotate = 0,
    this.flipH = false,
  });

  final Uint8List bytes;

  /// 0 — o'lchamni o'zgartirmaslik.
  final int maxSide;
  final int quality;
  final bool png;
  final int rotate;
  final bool flipH;
}

class ImageResult {
  const ImageResult(this.bytes, this.width, this.height);
  final Uint8List bytes;
  final int width;
  final int height;
}

/// Og'ir ishni asosiy oqimdan tashqarida bajaradi (UI qotmaydi).
Future<ImageResult> processImage(ImageJob job) => Isolate.run(() => _process(job));

ImageResult _process(ImageJob job) {
  var im = img.decodeImage(job.bytes);
  if (im == null) throw const FormatException('Rasm formati qo\'llab-quvvatlanmaydi');

  im = img.bakeOrientation(im);
  if (job.rotate != 0) im = img.copyRotate(im, angle: job.rotate);
  if (job.flipH) im = img.flip(im, direction: img.FlipDirection.horizontal);

  final longest = max(im.width, im.height);
  if (job.maxSide > 0 && longest > job.maxSide) {
    im = im.width >= im.height
        ? img.copyResize(im, width: job.maxSide, interpolation: img.Interpolation.average)
        : img.copyResize(im, height: job.maxSide, interpolation: img.Interpolation.average);
  }

  if (job.png) {
    return ImageResult(Uint8List.fromList(img.encodePng(im)), im.width, im.height);
  }

  // JPEG shaffoflikni qo'llamaydi: oq fonga joylaymiz.
  if (im.hasAlpha) {
    final bg = img.Image(width: im.width, height: im.height, numChannels: 3);
    img.fill(bg, color: img.ColorRgb8(255, 255, 255));
    img.compositeImage(bg, im);
    im = bg;
  }
  return ImageResult(
    Uint8List.fromList(img.encodeJpg(im, quality: job.quality)),
    im.width,
    im.height,
  );
}
